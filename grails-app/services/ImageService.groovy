import my.god.fb.HTML2ImageServiceimport java.io.OutputStream
class ImageService{

    def showImage(String idDocument, int width, int height, OutputStream ostream) {
            Document doc = Document.get(idDocument)    
            HTML2ImageService service = new HTML2ImageService()            
            service.convert(ostream, new String(doc.html), width, height)
            }
	
    def createImage(String fileName, String html, int width, int height) {                  HTML2ImageService service = new HTML2ImageService()                    service.createImage(fileName, html, width, height)        }        def deleteImage(String fileName, int width, int height) {                  HTML2ImageService service = new HTML2ImageService()                    service.deleteImage(fileName, width, height)        }
}
