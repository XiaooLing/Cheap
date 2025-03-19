function copyText(id) {
  const textBox = document.getElementById(id);
  const text = textBox.innerText.replace('Copy', ''); // Remove the button text
  navigator.clipboard.writeText(text)
    .then(() => {
      alert('Text copied to clipboard!');
    })
    .catch(err => {
      console.error('Error copying text: ', err);
    });
}
