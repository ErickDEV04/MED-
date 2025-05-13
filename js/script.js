document.getElementById('loginForm')?.addEventListener('submit', function(e) {
    e.preventDefault();
    fetch('php/login.php', {
        method: 'POST',
        body: new FormData(this)
    })
    .then(response => response.text())
    .then(data => {
        if (data.includes('dashboard')) {
            window.location.href = 'dashboard.html';
        } else {
            alert(data);
        }
    });
});
