class Document implements Comparable{
	String name
	Date docDate
	String display
	byte[] html
	Course course
	static belongsTo = Course	
	 static transients = [ "docDate", "display"]
	 static constraints = {
		    name()
		    html(maxSize:1000000)
		    }

    
	int compareTo(obj) {
	       id.compareTo(obj.id)
	   }

}
