package com.cronos.posidon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
public class UploadController {

    //Save the uploaded file to this folder
    //private static String UPLOADED_FOLDER = "/Users/namita/image-upload/";
	private static String UPLOADED_FOLDER = "/images-upload/";
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
    @GetMapping("/")
    public String index() {
        return "capture";
    }

    @GetMapping("/capture")
    public String capture() {
    	return "capture";
    }
    @PostMapping("/upload") // //new annotation since 4.3
    public String singleFileUpload(@RequestParam("file") MultipartFile file,
                                   RedirectAttributes redirectAttributes) {

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            logger.error("ERROR : Please select a file to upload");
            return "redirect:uploadStatus";
        }

        try {

            // Get the file and save it somewhere
            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOADED_FOLDER + "/"+file.getOriginalFilename());

            logger.info("Uplpading | Folder Path=" + path.getParent());

            Files.write(path, bytes);            
            
            redirectAttributes.addFlashAttribute("message",
                    "You successfully uploaded '" + file.getOriginalFilename() + "'");

            logger.info("Uploaded  Successfulle | File Path=" + path.getParent() +"/" + path.getFileName());
            
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("Error uploading file", e);
        }

        return "redirect:/uploadStatus";
    }

    @GetMapping("/uploadStatus")
    public String uploadStatus() {
        return "uploadStatus";
    }

}