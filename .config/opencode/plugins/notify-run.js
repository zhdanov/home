export const NotifyRun = async ({ $ }) => {
    const wasBusy = new Set();
    const notifiedQuestions = new Set();
    const notifiedPermissions = new Set();
    let lastToastSig = '';

    const send = async () => {
        const data = {
            echo: false,
            timeout: 15,
            fail_already: false,
        };

        await $`[ -x /usr/local/bin/run ] && /usr/local/bin/run --name=jobber__send_notification.job --data=${JSON.stringify(data)}`.nothrow();
    };

    return {
        event: async ({ event }) => {
            // 0) Questions / permissions: user input required.
            if (event.type === 'question.asked') {
                const id = event.properties?.id;
                if (typeof id === 'string' && id !== '' && !notifiedQuestions.has(id)) {
                    notifiedQuestions.add(id);
                    await send();
                }
                return;
            }

            if (event.type === 'permission.asked') {
                const id = event.properties?.id;
                if (typeof id === 'string' && id !== '' && !notifiedPermissions.has(id)) {
                    notifiedPermissions.add(id);
                    await send();
                }
                return;
            }

            // 1) Standard: notify when session becomes idle after being busy.
            if (event.type === 'session.status') {
                const sessionID = event.properties?.sessionID;
                const status = event.properties?.status;
                const statusType = status?.type;

                if (!sessionID || typeof sessionID !== 'string') {
                    return;
                }

                if (statusType === 'busy') {
                    wasBusy.add(sessionID);
                    return;
                }

                if (statusType === 'idle' && wasBusy.has(sessionID)) {
                    wasBusy.delete(sessionID);
                    await send();
                }

                return;
            }

            // 2) Questions: TUI shows a toast when the assistant asks user input.
            // In this case session may stay "busy", so we also notify here.
            if (event.type === 'tui.toast.show') {
                const title = (event.properties?.title ?? '').toString();
                const message = (event.properties?.message ?? '').toString();
                const variant = (event.properties?.variant ?? '').toString();

                const sig = `${title}::${variant}::${message}`;
                if (sig === lastToastSig) {
                    return;
                }
                lastToastSig = sig;

                const looksLikeQuestion =
                    variant === 'info'
                    && (title === 'Вопрос' || title.toLowerCase() === 'question');

                if (looksLikeQuestion) {
                    await send();
                }

                return;
            }
        },
    };
};
