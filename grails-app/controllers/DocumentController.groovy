import java.io.Fileimport java.io.FileOutputStreamclass DocumentController {
	def imageService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [documentInstanceList: Document.list(params), documentInstanceTotal: Document.count()]
    }

    def create = {
        def documentInstance = new Document()
        documentInstance.properties = params
        return [documentInstance: documentInstance]
    }

    def save = {
        def documentInstance = new Document(params)
        if (documentInstance.save(flush: true)) {        	def width = 110;        	def height = 110;            imageService.createImage("web-app/images/"+ documentInstance.course.id + "/"+ documentInstance.id +"/"            		, new String(documentInstance.html), width, height)            
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])}"
            redirect(action: "show", id: documentInstance.id)
        }
        else {
            render(view: "create", model: [documentInstance: documentInstance])
        }
    }

    def show = {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
            redirect(action: "list")
        }
        else {
            [documentInstance: documentInstance]
        }
    }

    def edit = {
        def documentInstance = Document.get(params.id)
        if (!documentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [documentInstance: documentInstance]
        }
    }		def myedit = {        def documentInstance = Document.get(params.id)        if (!documentInstance) {            return null        }        else {            return [documentInstance: documentInstance]        }    }

    def update = {
        def documentInstance = Document.get(params.id)
        if (documentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (documentInstance.version > version) {
                    
                    documentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'document.label', default: 'Document')] as Object[], "Another user has updated this Document while you were editing")
                    render(view: "edit", model: [documentInstance: documentInstance])
                    return
                }
            }
            documentInstance.properties = params
            if (!documentInstance.hasErrors() && documentInstance.save(flush: true)) {            	def width = 110;            	def height = 110;            	imageService.createImage("web-app/images/"+ documentInstance.course.id + "/"+ documentInstance.id +"/"                		, new String(documentInstance.html), width, height)
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'document.label', default: 'Document'), documentInstance.id])}"
                redirect(action: "show", id: documentInstance.id)
            }
            else {
                render(view: "edit", model: [documentInstance: documentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def documentInstance = Document.get(params.id)
        if (documentInstance) {
            try {
                documentInstance.delete(flush: true)                                def width = 110;        	def height = 110;            imageService.deleteImage("web-app/images/"+ documentInstance.course.id  + "/"+ documentInstance.id +"/"            		,  width, height)            		
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'document.label', default: 'Document'), params.id])}"
            redirect(action: "list")
        }
    }
	
    def showImage = {               
        response.setContentType("image/png")
        int width = params.width == null?300:Integer.parseInt(params.width)
        int height = params.width == null?300:Integer.parseInt(params.height)
        imageService.showImage(params.id, width, height,response.outputStream)
        
        }
}
