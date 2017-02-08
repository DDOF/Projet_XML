
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import java.io.File;
public class Unites {

   public static void main(String[] args) throws Exception {

     Document doc = DocumentBuilderFactory.newInstance()
     .newDocumentBuilder().newDocument();

     Element racine = doc.createElement("Unites");

     DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
     DocumentBuilder builder = factory.newDocumentBuilder();    
     Document document= builder.parse(new File("master.xml"));
     Element root = document.getDocumentElement();

     NodeList racineNoeuds = root.getChildNodes();
     int nbRacineNoeuds = racineNoeuds.getLength();

     for (int i = 0; i<nbRacineNoeuds; i++) {

      if(racineNoeuds.item(i).getNodeName() == "unite") {
         final Element unite = (Element) racineNoeuds.item(i);
         final Element nom = (Element) unite.getElementsByTagName("nom").item(0);

         Element item = doc.createElement("unite");
         item.appendChild(doc.createTextNode(nom.getTextContent()));
         racine.appendChild(item);
      }
   }


   doc.appendChild(racine);

      // sérialisation
   TransformerFactory myFactory = TransformerFactory.newInstance();
   Transformer transformer = myFactory.newTransformer();

   transformer.setOutputProperty(OutputKeys.ENCODING, "utf8");
   transformer.setOutputProperty(OutputKeys.INDENT, "yes");

   transformer.transform(new DOMSource(doc),
      new StreamResult(System.out));
}

}