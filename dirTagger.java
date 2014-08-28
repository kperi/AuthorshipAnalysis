
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.ling.TaggedWord;
import edu.stanford.nlp.ling.HasWord;
import edu.stanford.nlp.tagger.maxent.MaxentTagger;

class dirTagger {

  // retrieve an arrayList of files in a directory
  public static ArrayList<String> getFiles(String directory) 
  {
    ArrayList<String>results = new ArrayList<String>();
    
    File folder = new File(directory);
    File[] files = folder.listFiles();
    
    for (File file : files) {
      if (file.isFile()) {
        results.add(file.getName());
      }
    }
    
    return results;
  }


  // do the tagging
  private dirTagger() {}

  public static void main(String[] args) throws Exception {
    if (args.length != 2) {
      System.err.println("usage: java TaggerDemo modelFile dirToTag");
      return;
    }

    String modelFile = args[0];
    String directory = args[1];
    ArrayList<String> files = getFiles(directory);

    MaxentTagger tagger = new MaxentTagger(modelFile);

    for (int a = 0; a < files.length(); a++) {
      File thisFile = files.get(a);
      List<List<HasWord>> sentences = MaxentTagger.tokenizeText(new BufferedReader(new FileReader(thisFile)));
      for (List<HasWord> sentence : sentences) {
        ArrayList<TaggedWord> tSentence = tagger.tagSentence(sentence);
        System.out.println(Sentence.listToString(tSentence, false));
      }
    }
  }

}
