package item;

public class Jacket extends Item {

	public enum Size { S, M, L, XL, XXL };
	private Size size;
	
	public Jacket(String name, String color, Season season, Size size) {
		super(name, color, season);
		this.size = size;
	}
	
	public Size getSize() {
		return size;
	}

}
