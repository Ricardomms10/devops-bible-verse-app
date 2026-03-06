document.addEventListener('DOMContentLoaded', () => {
    const btn = document.getElementById('new-verse-btn');
    const verseText = document.getElementById('verse-text');

    // Fetch initial verse on load
    fetchVerse();

    btn.addEventListener('click', () => {
        // Add spin animation to button icon
        btn.classList.add('loading');
        fetchVerse();
    });

    async function fetchVerse() {
        // Fade out current text
        verseText.style.opacity = '0';

        try {
            const response = await fetch('/api/verse');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();

            setTimeout(() => {
                verseText.textContent = data.verse;
                verseText.style.opacity = '1';
                btn.classList.remove('loading');
            }, 300); // Wait for fade out

        } catch (error) {
            console.error('Error fetching verse:', error);
            setTimeout(() => {
                verseText.textContent = "Erro ao buscar versículo. Tente novamente.";
                verseText.style.opacity = '1';
                btn.classList.remove('loading');
            }, 300);
        }
    }
});
