// Import the libraries
const QRCode = require('https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js') ;



// Get a reference to the button element
const generateQRButton = document.getElementById('generate-qr-btn')

// Define the QR code content as an array of objects
const qrCodeContent = [
  { name: 'John Doe', email: 'john.doe@example.com' },
  { name: 'Jane Doe', email: 'jane.doe@example.com' },
  { name: 'Bob Smith', email: 'bob.smith@example.com' },
]

// Add a click event listener to the button
generateQRButton.addEventListener('click', () => {
  // Create a new PDF document
  const doc = new jsPDF()

  // Loop through the QR code content array and generate a QR code for each item
  qrCodeContent.forEach(async (item, index) => {
    // Generate the QR code data URL for the current item
    const qrCodeDataUrl = new QRCode(JSON.stringify(item))

    // Save the item data to the database using axios
    // try {
    //   const response = await axios.post('/api/save-item-data', item)
    //   console.log(response.data)
    // } catch (error) {
    //   console.error(error)
    // }

    // Add the QR code image to the PDF
    doc.addImage(qrCodeDataUrl, 'PNG', 10, (index * 60) + 10, 50, 50)

    // Add the item details to the PDF
    doc.text(70, (index * 60) + 30, `Name: ${item.name}`)
    doc.text(70, (index * 60) + 40, `Email: ${item.email}`)
  })

  // Save the PDF
  doc.save('qr-codes.pdf')
})
