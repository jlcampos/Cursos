class User {
	Long uid
	String name
	
	static hasMany = [ courses : Course ]
    static constraints = {
    }
}
