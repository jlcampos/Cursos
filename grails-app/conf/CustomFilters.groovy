import org.w3c.dom.Document;
class CustomFilters {   
   def filters = {
        // your filters here
        
        loginCheck	(controller:'noexisto', action:'*') {
        	before = {
        			    
        	
        }
   }
}