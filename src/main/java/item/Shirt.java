package item;

public class Shirt extends Item {

	public enum Size { S, M, L, XL, XXL };
	private Size size;
	
	public Shirt(String name, String color, Season season, Size size) {
		super(name, color, season);
		this.size = size;
	}

	public Size getSize() {
		return size;
	}
}
