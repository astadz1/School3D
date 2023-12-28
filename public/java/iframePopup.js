function openLinkPopup() {
    // cree un element dialog 
    var dialog = document.createElement('dialog');
    dialog.id = 'linkDialog';
    dialog.classList.add('dialog2');
    dialog.innerHTML = `<iframe src="Parrainage.php" width="100%" height="100%"></iframe>
                    <div class="close-button"><button onclick="document.getElementById('linkDialog').close();">❌</button></div>`;
    document.body.appendChild(dialog);
    dialog.showModal();
}
