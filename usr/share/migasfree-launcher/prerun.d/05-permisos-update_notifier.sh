# block update-notifier

if test -f /etc/xdg/autostart/update-notifier.desktop -a $(stat -c%a /etc/xdg/autostart/update-notifier.desktop) -ne 0 ; then
	chmod 000 /etc/xdg/autostart/update-notifier.desktop || :
fi
