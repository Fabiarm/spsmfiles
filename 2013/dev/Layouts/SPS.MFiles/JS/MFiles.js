function bytesToSize(control) {
    var bytes = control.value;
    var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
    if (bytes == 0) return 'n/a';
    var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
    var divControl = document.getElementById(control.id + '_span');
    control.title = Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
    divControl.innerHTML = Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
};