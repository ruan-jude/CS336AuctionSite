package userType;


public abstract class User {

	private String name;
	private String email;
	
	/**
	 * Constructor
	 */
	public User(String name, String email) {
		this.name = name;
		this.email = email;
	}
	
	public String getName() {
		return name;
	}
	
	public String getEmail() {
		return email;
	}
}
