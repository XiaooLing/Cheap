function copyText(txt) {
  navigator.clipboard.writeText(txt)
    .then(() => {
      alert('Text copied to clipboard!');
    })
    .catch(err => {
      console.error('Error copying text: ', err);
    });
}
