package item;

public class Pants extends Item {

	public class Size {
		private int width;
		private int length;
		
		public Size(int width, int length) {
			this.width = width;
			this.length = length;
		}
		
		public int getWidth() {
			return width;
		}
		public int getLength() {
			return length;
		}
		
		public String toString() {
			return width+" x "+length;
		}
	}
	
	Size size;
	
	public Pants(String name, String color, Season season, Size size) {
		super(name, color, season);
		this.size = size;
	}
	
	public Size getSize() {
		return size;
	}
}
