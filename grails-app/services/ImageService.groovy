import my.god.fb.HTML2ImageService
class ImageService{

    def showImage(String idDocument, int width, int height, OutputStream ostream) {
            Document doc = Document.get(idDocument)    
            HTML2ImageService service = new HTML2ImageService()            
            service.convert(ostream, new String(doc.html), width, height)
            }
	
    def createImage(String fileName, String html, int width, int height) {          
}