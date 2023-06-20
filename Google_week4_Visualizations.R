library(ggplot2)
library(plotly)
library(lattice)
library(rgl)
library(dygraphs)
library(leaflet)
library(highcharter)
library(patchwork)
library(gganimate)
library(ggridges)

## Buscar Cheat Sheet de ggplot2
## con la funcion "facets" se pueden hacer graficas por separado
library(palmerpenguins)
data(penguins)
View(penguins)

## Hacer una grafica de la relacion de masa corporal y largo de la aleta
## en las 3 especies de pinguinos
ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

## se empieza con la funcion ggplot() y el primer argumento es el dataset
## simbolo de "+" para agregar una nueva capa a la grafica
## geom_point() luego se elige "geom"  para agregar una funcion geom
## geom_point: graficas de puntos, geom_bar: grafica de barras
## hay diferentes funciones geom
## (mapping = aes(x = flipper_length_mm, y = body_mass_g)): cada funcion geom
## tiene un argumento de mapping. Esto define cuantas variables en tu conjunto 
## de datos son mapeadas a las propiedades visuales
## El argumento mapping esta asociado con la funcion aes().
## "x" y "y" determina que argumentos van en cada ejes

## La grafica muestra una asociacion positiva en este caso
## Entre mas grande el pinguino mas grande la aleta

## Para hacer un plot:
## ggplot(data= <DATA>) + <GEOM_FUNCTION>(mapping=aes(<AESTHETIC MAPPINGS>))

## Usando variables bill_length y bill_depth
ggplot(data = penguins) + geom_point(mapping = aes(x = bill_length_mm, y = bill_depth_mm))


## Para saber como se usa una funcion poner signo "?" al principio
## Ejemplo:
?geom_point
## El signo "+" siempre debe estar al final de una linea
## de codigo no al principio

## EJERCICIO CON GGPLOT

hotel_bookings <- read.csv("hotel_bookings.csv")
head(hotel_bookings)
colnames(hotel_bookings)

## Identificar a la gente que hace reservaciones antes
## Hipotesis de que la gente que tiene hijos reserva con anticipacion
ggplot(data = hotel_bookings) +
  geom_point(mapping = aes(x = lead_time, y = children))


## La hipotesis es incorrecta 
## La mayoria de las reservaciones anticipadas las hace gente con 0 hijos

## Saber que grupo de invitados reservan mas los fines de semana
## hipotesis: La gente que no tiene hijos reserva mas

ggplot(data = hotel_bookings) + 
  geom_point(mapping = aes(x = stays_in_weekend_nights, y = children))

## La hipotesis es correcta xd

## CAMBIAR AESTHETICS DE PLOT
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

## Agregar una nueva variable para poner color (species)
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species))

## Agregar "shape" a la variable species
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species, shape=species))

## Alpha sirve para hacer puntos mas transparentes 
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species, shape=species, alpha=species))


## Si queremos que todos los puntos sean de un solo color
## Se pone el color fuera del parentesis
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g), color="purple")

## Aesthetics en ggplot: color, tamaño y forma
## Ejemplo: 
##ggplot(data, aes(x=distance, y= dep_delay, color=carrier, size=air_time, shape = carrier)) +
  
  ##geom_point()

## DIFERENTES GEOMS
## geom_smooth + geom_point 
## geom_smooth nos muestra la tendencia de los datos
ggplot(data = penguins) + 
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(mapping=aes(x=flipper_length_mm, y = body_mass_g))

## Dos tipos de smoothing: "Loess" para plots con menos de 1000 puntos
## y "Gam" para plots con gran numero de puntos
## Ejemplo

## Loess
#ggplot(data, aes(x=, y=))+ 
  #geom_point() +       
  #geom_smooth(method="loess")

## Gam
#ggplot(data, aes(x=, y=)) + 
 # geom_point() +        
  #geom_smooth(method="gam", 
              #formula = y ~s(x))


## geom_smooth + linetype en species
## linetype: diferente linea para cada especie
ggplot(data = penguins) + 
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g, linetype=species))

## Jitter ayuda a la sobrelapacion, haciendo los puntos mas facil de encontrar
ggplot(data = penguins) + 
  geom_smooth(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_jitter(mapping = aes(x = flipper_length_mm, y = body_mass_g))

## Graficos de barra
## Barras por tipo de corte de diamante
ggplot(data=diamonds) + 
  geom_bar(mapping = aes(cut))

## Agregar color al contorno
ggplot(data=diamonds) + 
  geom_bar(mapping = aes(cut, color=cut))

## Agregar color como relleno
ggplot(data=diamonds) + 
  geom_bar(mapping = aes(cut, fill=cut))

## Una nueva variable "clarity" con stacked bar chat
## muestra 40 nuevas combinaciones con "cut" y "clarity"
ggplot(data=diamonds) + 
  geom_bar(mapping = aes(cut, fill=clarity))


## Facets: Te permite mostrar pequeños grupos, o subconjuntos de tus datos
## Te permite ver nuevos patrones de tus datos
## Dos funciones: facet_wrap() y facet_grid()

## Ver flipper_length y body_mass_g po especie
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  facet_wrap(~species)

## Un plot para cada corte de diamante
ggplot(data=diamonds) + 
  geom_bar(mapping = aes(x=color, fill=cut)) + 
  facet_wrap(~cut)

## facet_grid separa cada plot verticalmente por los valores de la primer 
## variable y horizontalmente por los valores de la segunda variable
## Variables sex y species
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  facet_grid(sex~species)

## Salen las tres especies de pinguino con los sexo: male, female y na

## Mostrar solo species con facet_grid
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  facet_grid(~species)

## Mostrar solo sex
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  facet_grid(~sex)

## EJERCICIO AESTHETICS AND VISUALIZATIONS
head(hotel_bookings)
colnames(hotel_bookings)

## Hacer un grafico de barra con distribution_channel y count
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel))

## Ver si la distribucion dependiendo el deposito y  segmento de mercado que representan
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel, fill=deposit_type))

##Tipo de segmento
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel, fill=market_segment))

## Separar graficos con facet
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_wrap(~deposit_type) 

## Rotar el titulo 45° para que titulos de "x" sean mas claros
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_wrap(~deposit_type) +
  theme(axis.text.x = element_text(angle = 45))

##segmento de mercado con titulos de eje x a 45°
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_wrap(~market_segment) +
  theme(axis.text.x = element_text(angle = 45))

## Tipo de deposito con face_grid
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_grid(~deposit_type) +
  theme(axis.text.x = element_text(angle = 45))

## Todo en una grafica
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = distribution_channel)) +
  facet_wrap(~deposit_type~market_segment) +
  theme(axis.text.x = element_text(angle = 45))

## Ejemplo para filtrar datos para graficas con la funcion filter()
## data %>%
  ## filter(variable1 == "DS") %>%  
  ## ggplot(aes(x = weight, y = variable2, colour = variable1)) +  
  ## geom_point(alpha = 0.3,  position = position_jitter()) + stat_smooth(method = "lm")

## EJERCICIO FILTERS AND PLOTS
##Relacion entre tiempo de espera de reservacion e invitados
## viajando con hijos
ggplot(data = hotel_bookings) + 
  geom_point(mapping = aes(x = lead_time, y = children))

## la mayoria no tiene hijos

## Hacer promocion para gente que tiene hijos

## Hacer una bar chart que muestre el tipo de hotel y segmento para 
## saber donde se ocupa hacer mas promocion
ggplot(data = hotel_bookings) + 
  geom_bar(mapping = aes(x = hotel, fill = market_segment))


## face_wrap para separar cada segmento de mercado
ggplot(data = hotel_bookings) + 
  geom_bar(mapping = aes(x = hotel)) +
  facet_wrap(~market_segment)

## Se considera mandar promocion a familias que hacen reservacion online 
## y en hoteles de ciudad
## Piden hacer un plot que relacione el tiempo de espera y 
## viaje con niños para las reservaciones de hotel en hoteles de ciudad

onlineta_city_hotels <- filter(hotel_bookings,
                               hotel=="City Hotel" &
                                 hotel_bookings$market_segment=="Online TA")

View(onlineta_city_hotels)

## Nombrar Data Frame
onlineta_city_hotels_v2 <- hotel_bookings %>%
  filter(hotel=="City Hotel") %>%
  filter(market_segment=="Online TA")

## Hacer un plot del Data Frame 
ggplot(data = onlineta_city_hotels) +
  geom_point(mapping = aes(x = lead_time, y = children))

## Resaltar barras de dos colores col = ifelse (x<2, 'blue', 'yellow')

## Para agreagar titulo usar funcion labs(title ="")
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length")

## Agregar subtitulos
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length", subtitle="Sample of Three Penguin Species")

## Agregar Captions
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length", subtitle="Sample of Three Penguin Species", 
       caption="Data collected by Dr. Kristen Gorman")


## funcion annotate para hacer anotaciones y reforzar una parte importante 
## de los datos
ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length", subtitle="Sample of Three Penguin Species", 
       caption="Data collected by Dr. Kristen Gorman") +
  annotate("text", x=220, y=3500, label="The Gentoos are the largest", color="purple",
           fontface="bold", size=4.5, angle=25)

##Asignarlo a una variable
p <- ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color=species)) +
  labs(title="Palmer Penguins: Body Mass vs. Flipper Length", subtitle="Sample of Three Penguin Species", 
       caption="Data collected by Dr. Kristen Gorman") +
  annotate("text", x=220, y=3500, label="The Gentoos are the largest", color="purple",
           fontface="bold", size=4.5, angle=25)
  
## Prueba de variable
p + annotate("text", x=220, y=3500, label= "The Genttos are the largest")

## Guardar plots en export
## O en ggsave("Three penguin species.png")


## EJERCICIO ANNOTATIONS SOLUTIONS
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = market_segment)) +
  facet_wrap(~hotel)

## Agregar titulo 
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = market_segment)) +
  facet_wrap(~hotel) +
  labs(title="Comparison of market segments by hotel type for hotel bookings")

## agregar el perido de los datos
min(hotel_bookings$arrival_date_year)
max(hotel_bookings$arrival_date_year)

## Guardarlos como variables para usralos en las etiquetas
mindate <- min(hotel_bookings$arrival_date_year)
maxdate <- max(hotel_bookings$arrival_date_year)

## Usar un subtitulo
## Funcion paste0() para agregar las nuevas variables creadas
## Si la informacion se actualiza no se teien que cambiar el codigo porque 
## las variables son dinamicas
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = market_segment)) +
  facet_wrap(~hotel) +
  labs(title="Comparison of market segments by hotel type for hotel bookings",
       subtitle=paste0("Data from: ", mindate, " to ", maxdate))

##Poner el subtitulo como caption
ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = market_segment)) +
  facet_wrap(~hotel) +
  labs(title="Comparison of market segments by hotel type for hotel bookings",
       caption=paste0("Data from: ", mindate, " to ", maxdate))

## Agregar titulos a los ejes "x" y "y"

ggplot(data = hotel_bookings) +
  geom_bar(mapping = aes(x = market_segment)) +
  facet_wrap(~hotel) +
  labs(title="Comparison of market segments by hotel type for hotel bookings",
       caption=paste0("Data from: ", mindate, " to ", maxdate),
       x="Market Segment",
       y="Number of Bookings")

       