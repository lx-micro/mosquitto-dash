
MODULO config.lua 
REQUIERE config.json
FECHA DE MODIFICACIÓN: 20/05/2016

Configuración para esp2866:

Los modúlos mínimos necesarios para funcionar:
    adc,bit,bmp085,cjson,coap,crypto,dht,file,gpio,i2c,mqtt,net,node,pwm,spi,tmr,uart,wifi

Archivos:
  1) config.json
    Este archivo contiene información sobre el dispositivo, (existen valores que no pueden quedar en blanco)
    
  2) config.lua
    Es el "<<parser>>" para el archivo config.json
    el código es muy sencillo (de hecho  cada función es la misma con solo con pequeñas variantes, gracias a copy&paste -> esto se debe optimizar)
    
    NOTAS:
      1. la navegación a través de nodos se hace de la siguiente forma: "nodo/valor"
      
        ejemplo:
      
        para obtener el valor de nodo config->name se hace de la siguiente manera:
      
        dt = json_read("config/name")
        print("Nombre: "..dt)
      
        lo cual da como resultado
      
        Nombre: Lolin
      
      2. Todos los ejemplos se basan en el archivo config.json original.
      
      3. Los nodo contiene otro nodo NO SE PUEDEN BORRAR a menos que se borren todos los subnodos
    
    lista de funciones:
      json_read() -> lectura de nodo json (devuelve el valor del nodo o nil en caso de estar vacío o no encontrarse el nodo)
    
    para usar:
      dofile("config.lua")
      
    para ejecutar:
    
      1) json_read()  -> requiere de un párametro necesario: cadena de tipo string, así para obtener el valor del nodo ssid se pasa el la cadena "config/wifi/ssid" para obtener PControl
      2) json_save() -> requiere de dos párametros necesarios del tipo string: el primero señala el nodo cuyo valor se desea cambiar y el segundo es el valor que se desea.
          
            Ejemplo para cambiar el valor pass del nodo "config/wifi/pass":
          
              json_save("config/wifi/pass","0987654321")
          
            Esta función devuelve true o false dependiendo de si se pudo o no realizar el cambio o si falta algún párametro.
          
            NOTA:
          
                El nodo cuyo valor pretende cambiarse DEBE EXISTIR o de lo contrario devuelve false
          
      3) json_rm() -> requiere una cadena de tipo string que establezca el nodo a borrar
      
            Ejemplo para borrar el subnodo type del archivo config.json, se hace lo siguiente:
          
              json_rm("config/type")
          
            NOTAS:
            
              a) Esta función devuelve true se se pudo borrar el nodo o false si el nodo no existe o no se pudo borrar o contiene subnodos o falto un párametro.
              b) Para poder borrar el nodo, es necesario que no cotnenga subnodos.
       
       4) json_add() -> Esta función requiere de dos párametros del tipo string: el primero señala el nodo a insertar y el valor del nodo.
       
            Ejemplo para añadir un valor al nodo config:
            
               json_add("config/version", "1.5")
               
            NOTA:
          
            a) En nodo debe existir previamente y no puede ser creado con json_add() (ESTO SE CAMBIARA EN FUTURAS VERSIONES)
            
       5) json_clear() -> Esta funcion requiere de un párametro necesario: cadena de tipo string para la ruta del nodo.
       
          Ejemplo para borrar un valor de un nodo:
           
            json_clear("config/version")
            
          Esta funcion devuelve true al eliminar el valor o false si no existe el nodo.
         
         
         