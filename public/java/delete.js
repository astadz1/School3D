
function confirmDelete(userId) {
    var result = confirm("Are you sure you want to delete this user?");
    if (result) {
        window.location.href = 'delete.php?id=' + userId;
    }
}