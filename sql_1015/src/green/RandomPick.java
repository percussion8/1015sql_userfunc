package green;

public class RandomPick {

	public static void main(String[] args) {
		String[] names = {"네그님", "루이네스님","메기드라몬님","청배님","라노님"};
		
		int pick = (int)(Math.random()*5);
		
		System.out.println(names[pick]);
	}

}
