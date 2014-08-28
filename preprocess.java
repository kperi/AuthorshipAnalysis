import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

class preprocess
{
	public static List<String> listFilesForFolder(final File folder, String relPath) 
	{
		List<String> files = new ArrayList<String>();
		for (final File fileEntry : folder.listFiles()) {
			if (fileEntry.isDirectory()) {
				List<String> innerFiles = listFilesForFolder(fileEntry, fileEntry.getName().toString() + '/');
				files.addAll(innerFiles);
			} else {
				//	        	System.out.println(fileEntry.getName());
				files.add(relPath + fileEntry.getName());
			}
		}
		//	    System.out.println(files.size());
		return files;
	}
	
	public static void main(String [] args) throws IOException 
	{
		String samples = "C:/Users/Daway Chou-Ren/Documents/REU/sampleSplit/" + args[0];
		String path = samples + args[0];
		File folder = new File(path);
		
		Charset charset = StandardCharsets.UTF_8;
		
		List<String> files = listFilesForFolder(folder, path);
		for (int a = 0; a < files.size(); a++) {
			Path thisPath = Paths.get(samples + files.get(a));
			String content = new String(Files.readAllBytes(thisPath), charset);
			content = content.replaceAll("[\\u2018\\u2019]", "'").replaceAll("[\\u201C\\u201D]", "\"");
			Files.write(thisPath, content.getBytes(charset));
		}
	}
}