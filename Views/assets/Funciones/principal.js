// ========== Sidebar Toggle ==========
document.addEventListener('DOMContentLoaded', () => {
  const toggleBtn = document.getElementById('toggleSidebar');
  const sidebar = document.getElementById('sidebar');

  if (toggleBtn && sidebar) {
    toggleBtn.addEventListener('click', () => {
      sidebar.classList.toggle('show');
    });
  }
});

// ========== Modal (Login, etc.) ==========
function openModal() {
  const overlay = document.getElementById("modalOverlay");
  const dialog = document.getElementById("modalDialog");

  if (overlay && dialog) {
    overlay.classList.remove("closed");
    overlay.classList.add("open");

    dialog.classList.remove("closed");
    dialog.classList.add("open");
  }
}

function closeModal() {
  const overlay = document.getElementById("modalOverlay");
  const dialog = document.getElementById("modalDialog");

  if (overlay && dialog) {
    overlay.classList.remove("open");
    overlay.classList.add("closed");

    dialog.classList.remove("open");
    dialog.classList.add("closed");
  }
}
