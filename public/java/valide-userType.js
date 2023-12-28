
const userTypeInput = document.getElementById('user');
userTypeInput.addEventListener('input', () => {
    const selectedOption = document.querySelector('#userType option[value="' + userTypeInput.value + '"]');
    if (!selectedOption) {
        userTypeInput.value = '';
        userTypeInput.setCustomValidity('Please select a valid user type.');
    } else {
        userTypeInput.setCustomValidity('');
    }
});
