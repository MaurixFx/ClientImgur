# ClientImgur
App Cliente Imgur desarrollada en Swift 3 

Para el desarrollo de esta aplicación se utilizaron las librerias:
- Alamofire
- SwiftyJSON
- SDWebImage

Dentro del proyecto, esta la clase Constants, donde declaramos todas las URL y lo mas importante el CLIENT ID que nos 
servira para conectarnos a la API de Imgur.

La aplicación comienza con la pantalla inicial donde se muestran todos los tags dentro de una TableView, estos se obtienen de la url:
"https://api.imgur.com/3/tags/".

Posteriormente mostramos una una tableView se muestran las imagenes asociadas al tag seleccionado con la url ejemplo: https://api.imgur.com/3/gallery/t/spirit_animal

Luego para visualizar el Post seleccionamos la imagen y en la siguiente vista podremos ver toda la información, Like, no Likes, Commentarios, descripción, entre otros.

Se implemento un modulo de subida de imagen a Imgur el cual ocupa la siguiente url: "https://api.imgur.com/3/image"

Toda la documentación para poder trabajar con la API aca: https://apidocs.imgur.com/
