$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;
	var previewNode = document.querySelector("#template");
	previewNode.id = "";
	var previewTemplate = previewNode.parentNode.innerHTML;
	previewNode.parentNode.removeChild(previewNode);
	// grap our upload form by its id
	$("#new_upload").dropzone({
		// restrict image size to a maximum 1MB
		maxFilesize: 10,
		acceptedFiles: ".jpeg,.jpg,.png,.gif, .pdf",
		// changed the passed param to one accepted by
		// our rails app
		paramName: "upload[image]",
		// show remove links on each image upload
		addRemoveLinks: true,
		// if the upload was successful
		previewTemplate: previewTemplate,
		previewsContainer: "#previews", // Define the container to display the previews
		success: function(file, response){
			console.log(file)
			console.log(response)
			$.ajax({
				type: 'GET',
				url: '/render-progress-limit',
				data: {music_id: $('#upload_music_id').val()},
				success: function(data){
					console.log(data.message);
				}
			});
			// find the remove button link of the uploaded file and give it an id
			// based of the fileID response from the server
			$(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
			// add the dz-success class (the green tick sign)
			$(file.previewElement).addClass("dz-success");
		},
		//when the remove button is clicked
		removedfile: function(file){
			// grap the id of the uploaded file we set earlier
			var id = $(file.previewTemplate).find('.dz-remove').attr('id'); 
			// make a DELETE ajax request to delete the file
			$.ajax({
				type: 'DELETE',
				url: '/uploads/' + id,
				success: function(data){
					console.log(data.message);
					$('#'+id).parent().remove()
					$.ajax({
						type: 'GET',
						url: '/render-progress-limit',
						data: {music_id: $('#upload_music_id').val()},
						success: function(data){
							console.log(data.message);
						}
					});
				}
			});
		}
	});	
});