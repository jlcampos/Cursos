class Course {
String name
User user
SortedSet documents
byte[]  description
static belongsTo = User
static hasMany = [ documents : Document ]
    static constraints = {
    name()
    description()
    documents()
    }

}
