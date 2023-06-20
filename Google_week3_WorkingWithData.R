### ACTUALIZACION DE GOOLGLE 20/06/2023 10:53 am llll
### Trabajando en un nuevo proyecto
##NUEVO CAMBIO
###cambio

###nuevo nuevo
library("tidyverse")
library("lubridate")

today()
now()

## Paso 2: Ver Datos
head(diamonds)
str(diamonds)
glimpse(diamonds)

## Nombres de columnas
colnames(diamonds) 

## Paso 4: Limpiar Datos

## Renombrar columna
rename(diamonds, carat_new = carat)

## Se puede renombrar mas de una variable
rename(diamonds, carat_new = carat, cut_new = cut)

## Resumen de Datos y saber media de datos
summarize(diamonds, mean_carat = mean(carat))

## Resumen de tabla de Datos
summary(diamonds)

## Paso 4: Visualizar Datos
ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()

## Cambiar el color que representa cada variable, ejemplo: el color de cada corte del diamante
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point()


## Separar grafica por componentes
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point() +
  facet_wrap(~cut)


## Paso 5: Documentacion
## Poner titulos en Markdown doble ## y boton de "knit" para compilar el documento
## Shortcut para poner un chunk : ctrl + alt+ i
## Shortcut para corret un knit: ctrl + shift + k 
## Shortcut para guardar un documento: ctrl + s

## Pipes
data("ToothGrowth")
View(ToothGrowth)

## Filtrar y organizar datos con dplyr
filtered_tg <- filter(ToothGrowth, dose==0.5)
View(filtered_tg)

## Acomodar la informacion emodo ascendente con los datos filtrados anteriormente
arrange(filtered_tg, len)

## Nested function: funcion contenida en otra funcion
## Shortcut para poner un pipe ctrl + shit + M
filtered_tooththgrowth <- ToothGrowth %>% 
  filter(dose==0.5) %>% 
  arrange(len)
View(filtered_tooththgrowth)

## Agrupar con funcion group_by yn "na.rm = T" le dice que hacer con los valores perdidos 
## y .group="drop" para asegurar que esta agrupado correctamente
## longitud promedio cuando la dosis del diente es igual a 0.5 por cada suplemento
filtered_tooththgrowth <- ToothGrowth %>% 
  filter(dose==0.5) %>% 
  group_by(supp) %>% 
  summarize(mean_len = mean(len, n.a.rm =T), .group="drop")
View(filtered_tooththgrowth)

## DATA FRAMES: Coleccion de columnas
## Tibbles es similar a los data frames y nunca cambian los nombres de las variables y nunca
## crean nombres de filas y finalmente hacen las impresionde R mas facil
## Los Tibbles solo muestran las primeras diez filas y el mayor numero de columnas posible
## Tidy data: es una foma de estandarizar la organizacion de los datos dentro de R
## Variables organizadas en columnas y observaciones en filas, cada valor tiene su celda

data("diamonds") ## Conjunto de datos de ggplot2
View(diamonds)
head(diamonds)
str(diamonds)
colnames(diamonds)

## Funcion "mutate" para crear nueva columna "carat_2"
mutate(diamonds, carat_2 = carat*100)


## CREATE YOUR OWN DATA FRAME
names <- c("pedrito", "paty", "daniel")
age <-  c(75, 72, 58)
people <- data.frame(names, age)
View(people)
head(people)
str(people)
glimpse(people)
colnames(people)
mutate(people, age_in_20 = age + 20)


## Los Tibbles te muestran las primeras diez filas de un dataset
## CREAR TIBBLES
data(diamonds)
View(diamonds)

## dataset como tibbles
as_tibble(diamonds)


j## Data-import basics

## Para ver los datasets precargados en R
data()

## ejemplo
data(mtcars)
## el dataset aparece cargado en el Environment

## Preview de dataset
mtcars


## readr PACKAGE
## para leer formatos: read_csv(), read_tsv(), read_delim(), read_fwf(), read_table(), read_log()
## ejemplo ruta del csv: “readr_example(“mtcars.csv”)
## Se lee asi:

read_csv(readr_example("mtcars.csv"))

## para leer archivos de excel directamente cargar: library(readxl)
## read_excel()
## Yo uso read.csv() y write.csv()

## Ejercicio Importing and working with data
## Para cambiar de directorio ir  a session -> set working directory o con "setwd()"
bookings_df <- read_csv("hotel_bookings.csv")
list.files()

head(bookings_df)
str(bookings_df)
colnames(bookings_df)

##  Crear otro data frame usando bookings_df que se enfoque en el average daily rate (adr)
## y adults 
new_df <- select(bookings_df, 'adr', adults)

## Crear nuevas variables: "total"
mutate(new_df, total = adr / adults)



## CLEANING UP WITH THE BASICS
library("here")
library("skimr")
library("janitor")
library("dplyr")
library("palmerpenguins") ## Dataset de pinguinos xd

## Funcion para resumen comprensivo del dataset
skim_without_charts(penguins)
glimpse(penguins)
head(penguins)

## Selecccionas Especies
penguins %>% 
  select(species)

## Cada columna excepto especies con "-"
penguins %>% 
  select(-species)

## Renombrar columna
penguins %>% 
  rename(island_new= island)

## rename_with renombra columnas para ser mas consistentes
## toupper todas en mayusculas, tolower todas en minusculas
rename_with(penguins, toupper)
rename_with(penguins, tolower)

## clean_names se asegura de poner solo caracteres, numeros y guiones bajos
clean_names(penguins)


## Organizar datos por bill_lenght_mm de forma ascendente
penguins %>% arrange(bill_length_mm)

## O al reves 
penguins %>% arrange(-bill_length_mm)


## Guardar dataset
penguins2 <- penguins %>%  arrange(-bill_length_mm)
View(penguins2)


## Agrupar por isla y quitar los datos perdidos (NA) y sacar medias de mean_bill_length
penguins %>%  group_by(island) %>%  
  drop_na() %>% 
  summarize(mean_bill_length_mm = mean (bill_length_mm))


## Sacar Maximos de bill_length_mm
penguins %>%  
  group_by(island) %>%  
  drop_na() %>% 
  summarize(max_bill_length_mm = max (bill_length_mm))


## Agrupado por isla y especie y media y maximo de bill_length_mm y ordenado por mean_bl de forma ascendente
penguins %>% 
  group_by(species, island) %>%  
  drop_na() %>% 
  summarize (max_bl = max (bill_length_mm), mean_bl = mean(bill_length_mm)) %>% 
  arrange(mean_bl)                                                           

## Filtrar resultados por especie Adelie
penguins %>% filter(species=="Adelie")

## ## Filtrar resultados por especie Adelie y sin datos perdidos
penguins %>% filter(species=="Adelie") %>% drop_na()


## Ejercicio Cleaning Data
head(bookings_df)
str(bookings_df)
glimpse(bookings_df)
colnames(bookings_df)

## Cleaning data
trimmed_df <-  bookings_df %>% 
  select(hotel, is_canceled, lead_time)

## Renombrar variable "hotel" por "hotel_type"
trimmed_df <-  bookings_df %>% 
  select(hotel, is_canceled, lead_time) %>% 
  rename(hotel_type = hotel)

## Otra tarea comun es separar o combinar datos en diferentes columnas
## En este ejemplo, puedes combinar el "arrival_month" y el "year" en una columna
## usando la funcion unite()
example_df <- bookings_df %>%
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_month_year, c("arrival_date_month", "arrival_date_year"), sep = " ")

View(example_df)
## Hacer columna para sumar adults, children y babies en una reservacion para el numero total de personas

total_guests <- bookings_df %>% 
  mutate(guests = adults + children + babies)

head(total_guests)

## Calcular el numero total de reservaciones canceladas y tiempo promedio de reservacion.
## Hacer columna llamada number_cancelled para representael total de reservaciones canceladas
## y hacer columna llamada average_lead_time para representar el tiempo promedio
## Usar la funcion summarize()
total_guests <- bookings_df %>% 
  summarize(number_canceled = sum(is_canceled), average_lead_time = mean(lead_time))

head(total_guests)

## Opcional: Crear manualmente un data frame 
id <- c(1:10)

name <- c("John Mendes", "Rob Stewart", "Rachel Abrahamson", "Christy Hickman", "Johnson Harper", "Candace Miller", "Carlson Landy", "Pansy Jordan", "Darius Berry", "Claudia Garcia")

job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")

employee <- data.frame(id, name, job_title)

print(employee)

## Separar columnas
separate(employee, name,into=c('first_name', 'last_name'), sep =' ')

##Nuevas columnas
first_name <- c("John", "Rob", "Rachel", "Christy", "Johnson", "Candace", "Carlson", "Pansy", "Darius", "Claudia")
last_name <- c("Mendes", "Stewart", "Abrahamson", "Hickman", "Harper", "Miller", "Landy", "Jordan", "Berry", "Garcia")
job_title <- c("Professional", "Programmer", "Management", "Clerical", "Developer", "Programmer", "Management", "Clerical", "Developer", "Programmer")
employee <- data.frame(id, first_name, last_name, job_title)

print(employee)
## Unir columnas

unite(employee, 'name', first_name, last_name, sep=' ')

## Para agregar columnas con calculos mutate()
View(penguins)

## Convertir gramos a kilogramos de body_mass_g
penguins %>% 
  mutate(body_mass_kg = body_mass_g/1000)

## Convertir flipper_length_mm de milimetros a metros
penguins %>% 
  mutate(body_mass_kg = body_mass_g/1000, flipper_length_m = flipper_length_mm/1000)

## Funcion pivot_longer() para incrementar el numero de filas y decrecer el numero de columnas
## pivot_wider() para tener mas columnas y menos filas


## MISMA INFORMACION DIFERENTE SALIDA
library("Tmisc")
data("quartet")

View(quartet)

## Agrupar informacion por conjunto: mean para medias, sd para desviacion estandar
## y cor para correlacionar
quartet %>% 
  group_by(set) %>% 
  summarize(mean(x),sd(x),mean(y), sd(y), cor(x,y))

## Al parecer tienen correlacion

## Visualizar datos en ggplot2 
ggplot(quartet, aes(x,y)) + geom_point() + geom_smooth(method=lm, se=FALSE) + facet_wrap(~set)


## La informacion es diferente cuando la visualizamos

## El paquete datasauRus crea graficas con la informacion Anscombe en diferente formas ¿ooook? xs
library(datasauRus)


ggplot(datasaurus_dozen, aes(x=x, y=y, colour=dataset))+geom_point()+theme_void()+theme(legend.position = "none")+facet_wrap(~dataset,ncol=3 )

## La funcion "bias" en R encuentra la cantidad promedio que el resultado actual es mayor
## que el resultado predicho
## Esta incluido en el paquete "SimDesign"
library(SimDesign)
## Si el modelo esta insesgado el resultado deberia ser cercano a cero
## Un resultado alto indica que tu resultado podria estar sesgado
actual_temp <- c(68.3, 70, 72.4, 71, 67, 70)
predicted_temp <- c(67.9, 69, 71.5, 70, 67, 69)
bias(actual_temp, predicted_temp)

## Una tienda videjuegos quiere saber si es necesario un restock de videjuegos
## comparando las ventas del lanzamiento con las ventas actuales
actual_sales <- c(150, 203,137, 247, 116, 287)
predicted_sales <- c(200, 300, 150, 250, 150, 300)
bias(actual_sales, predicted_sales)
## El resultado es negativo por lo cual es muy cerca de cero
## La tienda deberia hacer un restock de los juegos

## La funcion sample() te permite tener muestras aleatorias de un dataset


## EJERCICIO: CHANGING YOUR DATA
hotel_bookings <- read_csv("hotel_bookings.csv")
head(hotel_bookings)
str(hotel_bookings)
colnames(hotel_bookings)
glimpse(hotel_bookings)

## Ordenar datos en forma descendente
arrange(hotel_bookings, desc(lead_time))
  
## Crear un nuevo data frame
  hotel_bookings_v2 <- arrange(hotel_bookings, desc(lead_time))
 head(hotel_bookings_v2)
 
 ## Maximos y minimos de lead_time 
 ## Siempr eescribir el nombredeldataset$columna
 max(hotel_bookings$lead_time) 
 min(hotel_bookings$lead_time)
 
 ## Tiempo de espera promedio de reservacion
 mean(hotel_bookings$lead_time)
 
 ## Tiempo de espera promedio de reservacion por ciudad de hoteles
 hotel_bookings_city <- filter(hotel_bookings, hotel_bookings$hotel=="City Hotel")
head(hotel_bookings_city) 
mean(hotel_bookings_city$lead_time)
 
## Maximo y minimo de tiempo de espera 
## que tan diferentes son de los hoteles resort con group_by() y summarize()
## Guardar el dataset en un data frame llamado "hotel_summary"
hotel_summary <- hotel_bookings %>%
group_by(hotel) %>%
summarise(average_lead_time=mean(lead_time),
min_lead_time=min(lead_time),
max_lead_time=max(lead_time))

head(hotel_summary)
