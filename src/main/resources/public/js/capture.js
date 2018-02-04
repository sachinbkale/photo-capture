function preview_snapshot() {
	// freeze camera so user can preview pic
	Webcam.freeze();
	
	// swap button sets
	document.getElementById('pre_take_buttons').style.display = 'none';
	document.getElementById('post_take_buttons').style.display = '';
	
	document.getElementById('menu-preview').style.display = 'none';
	document.getElementById('menu-take-another').style.display = '';
	document.getElementById('menu-save').style.display = '';
}

function cancel_preview() {
	// cancel preview freeze and return to live camera feed
	Webcam.unfreeze();
	
	// swap buttons back
	document.getElementById('pre_take_buttons').style.display = '';
	document.getElementById('post_take_buttons').style.display = 'none';
	document.getElementById('menu-preview').style.display = '';
	document.getElementById('menu-take-another').style.display = 'none';
	document.getElementById('menu-save').style.display = 'none';
}
/**
 * Convert a base64 string in a Blob according to the data and contentType.
 * 
 * @param b64Data {String} Pure base64 string without contentType
 * @param contentType {String} the content type of the file i.e (image/jpeg - image/png - text/plain)
 * @param sliceSize {Int} SliceSize to process the byteCharacters
 * @see http://stackoverflow.com/questions/16245767/creating-a-blob-from-a-base64-string-in-javascript
 * @return Blob
 */
function b64toBlob(b64Data, contentType, sliceSize) {
        contentType = contentType || '';
        sliceSize = sliceSize || 512;

        var byteCharacters = atob(b64Data);
        var byteArrays = [];

        for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
            var slice = byteCharacters.slice(offset, offset + sliceSize);

            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }

            var byteArray = new Uint8Array(byteNumbers);
            byteArrays.push(byteArray);
        }
      var blob = new Blob(byteArrays, {type: contentType});
      return blob;
}

function blobToFile(theBlob, fileName){
    //A Blob() is almost a File() - it's just missing the two properties below which we will add
    theBlob.lastModifiedDate = new Date();
    theBlob.name = fileName;
    return theBlob;
}

function generateQuickGuid() {
    return Math.random().toString(36).substring(2, 15) +
        Math.random().toString(36).substring(2, 15);
}

function save_photo() {
	// actually snap photo (from preview freeze) and display it
	Webcam.snap( function(data_uri) {
		// display results in page
		document.getElementById('results').innerHTML = 
			'<h2>Your captured image:</h2>' + 
			'<img src="'+data_uri+'"/>';
		// swap buttons back
		document.getElementById('pre_take_buttons').style.display = '';
		document.getElementById('menu-preview').style.display = '';
		
		document.getElementById('post_take_buttons').style.display = 'none';
		document.getElementById('menu-take-another').style.display = 'none';
		document.getElementById('menu-save').style.display = 'none';
		
		
		var form = document.getElementById("myAwesomeForm");

		var ImageURL = data_uri;		
		// Split the base64 string in data and contentType
		var block = ImageURL.split(";");
		// Get the content type of the image
		var contentType = block[0].split(":")[1];// In this case "image/gif"
		// get the real base64 content of the file
		var realData = block[1].split(",")[1];// In this case "R0lGODlhPQBEAPeoAJosM...."

		// Convert it to a blob to upload
		var myBlob = b64toBlob(realData, contentType);
		//var myFile = blobToFile(myBlob, "my-image.png");
		var mfile = new File([myBlob], "name");
		
		// Create a FormData and append the file with "image" as parameter name
		var formDataToUpload = new FormData(form);
		//formDataToUpload.append("image", blob);
		formDataToUpload.append("file", myBlob, "my-image-" + generateQuickGuid() +".png");
		//formData.append('file', file);

		  var xhr = new XMLHttpRequest();
		  // Add any event handlers here...
		  xhr.open('POST', form.getAttribute('action'), true);
		  xhr.send(formDataToUpload);

		  return false; // To avoid actual submission of the form
	} );
}
