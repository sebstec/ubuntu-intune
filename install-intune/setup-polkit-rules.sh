#!/bin/bash
# this script sets up polkit as such that intune portal does not require manual authentication to run the configured scripts
# beware of the security implications!

USER="$(id -u -n 1000)"

if [[ $EUID -ne 0 ]]; 
then
    echo "You must run this script as root" 2>&1
    exit 1
fi

if ! (id -u -n 1000);
then
    echo "user with id 1000 does not exist. manually change the user account which should be configured in the script"
    exit 1
fi

if [ "$(ls /etc/polkit-1/rules.d/| grep -ic '01')" -ge 1 ]; 
then
    echo "You already have a rules files with priority 01 in /etc/polkit-1/rules.d/! remove it or reconfigure the script" 2>&1
    exit 1
fi

echo "/* Allow intune scripts to execute any actions
 * without password authentication, similar to \"sudo NOPASSWD:\"
 */
polkit.addRule(function(action, subject) {
    if (action.id == \"com.microsoft.intune.actions.ConfigureDevice\" && subject.local == true && subject.user == \"$USER\") {
            return polkit.Result.YES;
    }
});" >> /etc/polkit-1/rules.d/01-intune.rules

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE policyconfig PUBLIC
 \"-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN\"
 \"http://www.freedesktop.org/standards/PolicyKit/1.0/policyconfig.dtd\">
<policyconfig>
  <vendor>Microsoft</vendor>
  <vendor_url>https://microsoft.com</vendor_url>
  <icon_name>intune</icon_name>

  <action id=\"com.microsoft.intune.actions.ConfigureDevice\">
    <description gettext-domain=\"intune\">Configuring your device</description>
    <message gettext-domain=\"intune\">Authorization is required to apply configuration required by your organization.</message>
    <defaults>
      <allow_any>no</allow_any>
      <allow_inactive>no</allow_inactive>
      <allow_active>auth_admin_keep</allow_active>
    </defaults>
    <annotate key=\"org.freedesktop.policykit.exec.path\">/opt/microsoft/intune/bin/intune-agent</annotate>
  </action>
</policyconfig>" >> /usr/share/polkit-1/actions/com.microsoft.intune.policy
