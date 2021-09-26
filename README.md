Protocol handler to open YouTube audio/video links directly in VLC and/or MPV media players.

A custom plugin of TinyTinyRSS adds vlc://, vlca:// or mpv:// to the beginning of a video URL to allow it to be opened in these players directly.

## Install VLC Player

```
sudo snap install vlc
```

## Install MPV Media Player

```
sudo apt install -y mpc
```

## Open video in MPV Media Player

To open a video url on the command line in MPV Media Player , use the following command

```
xdg-open mpv://https://www.youtube.com/watch?v=H7D-k-_3phI
```

## Open video in VLC Player

To open a video url on the command line in VLC , use the following command

```
xdg-open vlc://https://www.youtube.com/watch?v=H7D-k-_3phI
```

## Listen to audio in VLC Player

To listen to audio only in VLC Player , use the following command

```
xdg-open vlca://https://www.youtube.com/watch?v=H7D-k-_3phI
```

## Mozilla Firefox Extension

Add context menu items to Mozilla Firefox to open video links in MPV/VLC Players directly from youtube's (and other) website(s).

Install this extension: [Custom Right Click Menu](https://addons.mozilla.org/firefox/addon/custom-right-click-menu/)

### Import Settings

Open settings of extension and copy/paste the contents of **firefox-custom-right-click-menu-extension-settings.json** file in to the import text box.
Click the **IMPORT** button, and the extension will automatically recreate the custom menu.

### Export Settings from Firefox

Open settings of extension and click the **EXPORT** button.
Copy the content of the json file in to **firefox-custom-right-click-menu-extension-settings.json** file of this repository.

In Visual Studio Code, press **Ctrl+Shift+I** to format json document (make it readable)

### Manual Configuration

To configure the extension manually, add the following two items with their respective scripts on the settings page.

#### Open video in MPV player

Click on button **ADD SCRIPT**, add **Open in MPV Player** as Name, add the following script as **MAIN**, and click **SAVE** button

```
function openInNewTab(href) {
  Object.assign(document.createElement('a'), {
    target: '_blank',
    href: href,
  }).click();
}

var target = crmAPI.contextData.target; // Get the clicked element
if (!target) { // Make sure it exists, if it doesn't, show an alert
    alert('No target selected');
    return;
}

// Find the closest link to what was clicked
var currentElement = target;
while (currentElement && !currentElement.href) {
    currentElement = currentElement.parentNode; 
}

// If we selected a link, open the new URL with the
// link target pasted in
if (currentElement && currentElement.href) {
    // Change the URL below to point to your preferred URL
    openInNewTab(`mpv://${currentElement.href}`);
} else {
	// If nothing was selected, show an alert
    alert('Target is not a link!');
}
```

#### Open video in VLC player

Click on button **ADD SCRIPT**, add **Open in VLC Player** as Name, add the following script as **MAIN**, and click **SAVE** button

```
function openInNewTab(href) {
  Object.assign(document.createElement('a'), {
    target: '_blank',
    href: href,
  }).click();
}

var target = crmAPI.contextData.target; // Get the clicked element
if (!target) { // Make sure it exists, if it doesn't, show an alert
    alert('No target selected');
    return;
}

// Find the closest link to what was clicked
var currentElement = target;
while (currentElement && !currentElement.href) {
    currentElement = currentElement.parentNode; 
}

// If we selected a link, open the new URL with the
// link target pasted in
if (currentElement && currentElement.href) {
    // Change the URL below to point to your preferred URL
    openInNewTab(`vlc://${currentElement.href}`);
} else {
	// If nothing was selected, show an alert
    alert('Target is not a link!');
}
```

#### Listen to audio in VLC player

Click on button **ADD SCRIPT**, add **Listen in VLC Player** as Name, add the following script as **MAIN**, and click **SAVE** button

```
function openInNewTab(href) {
  Object.assign(document.createElement('a'), {
    target: '_blank',
    href: href,
  }).click();
}

var target = crmAPI.contextData.target; // Get the clicked element
if (!target) { // Make sure it exists, if it doesn't, show an alert
    alert('No target selected');
    return;
}

// Find the closest link to what was clicked
var currentElement = target;
while (currentElement && !currentElement.href) {
    currentElement = currentElement.parentNode; 
}

// If we selected a link, open the new URL with the
// link target pasted in
if (currentElement && currentElement.href) {
    // Change the URL below to point to your preferred URL
    openInNewTab(`vlca://${currentElement.href}`);
} else {
	// If nothing was selected, show an alert
    alert('Target is not a link!');
}
```
