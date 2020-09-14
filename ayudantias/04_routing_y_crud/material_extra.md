# Un poco de testing con Rspec...

Acá podrán encontrar unos ejemplos de _tests_ que no se alcanzaron a ver en la ayudantía.

OJO: en muchos de los ejemplos se utiliza más de un _expect_ por _test_. Para seguir buenas practicas, se te recomienda que los separes.

## Test de Request

Como vimos en la ayudantía pasada, hacer test no es dificil!. Asi que repasemos en primer lugar los de tipo **GET**.

Primero que todo, todo test debe empezar indicando el `tipo de solicitud` que se hará y el `path` donde se ejercerá esta solicitud:

```ruby
describe "GET /series/index" do
end
```

Luego en esta seccion de condigo se pueden poner diversos test que harán sobre el mismo path, empezando con un `it "<Descripcion del test>"`:

```ruby
describe "GET /series/index" do

    it "should return a succesful request" do
      get series_index_path
      expect(response).to have_http_status(200)
    end

    it "should render index view" do
      get series_index_path
      expect(response).to render_template(:index)
    end

end
```

- Podemos notar que el primer test se encarga de **verificar que la request se haga correctamente** por lo que envía una solicitud de tipo `get` al helper `series_index_path`, lo cual retorna una variable `response` que es comparado con `have_http_status(200)` para verificar que todo está bien.
- El segundo test es similar al anterior pero busca verificar que si se envía la solicitud de tipo `get` al helper, entonces este hará _render_ de la vista `index`, por lo tanto, si el metodo del controlador asociado al helper renderiza la vista `index` entonces este corresponderá a `:index`.

Ahora veremos un ejemplo de solicitud de tipo **POST** para simular que se envía un formulario con los parametros correctos y verificar si es recibido correctamente.

El test es bastante simple porque solo debemos enviar una solicitud post al metodo del controlador con los parametros necesarios, donde sabemos de antemano que si los parametros están correctos nos redirijirá de nuevo al index por las condiciones que definimos:

```ruby
# Accion create de 'series_controller.rb'
    (...)

    if @serie.save
      redirect_to series_index_path, notice: "Serie agregada exitosamente."
    else
      redirect_to series_new_path, notice: "Error al guardar serie"
    end
```

Por lo tanto el test sería así:

```ruby
describe "POST /series" do
    it "create a serie and redirect to serie's page" do
        post series_path, :params => {:serie => {:nombre => "Test_serie", :puntuacion => 9, :comentario => "Se parece a esa que era muy buena..."}}

        expect(response).to redirect_to(series_index_path)
    end
end
```

A pesar de que el test anterior está totalmente correcto, sabemos que para enviar un formulario en la aplicación suceden 3 cosas, primero debemos de ir a la vista del form, rellenar y enviar el formulario, a lo cual nos redirijirá de vuelta al index con un mensaje de confirmación. Por lo que podríamos hacer un test un poco más complejo que describa todos estos pasos:

```ruby
describe "POST /series" do
    it "create a serie and redirect to serie's page with the notice" do
        get series_new_path
        expect(response).to render_template(:new)

        post series_path, :params => {:serie => {:nombre => "Test_serie", :puntuacion => 9, :comentario => "Se parece a esa que era muy buena..."}}

        expect(response).to redirect_to(series_index_path)

        follow_redirect! #Como su nombre lo dice, sigue el redirect cambiando el "response"

        expect(response).to render_template(:index)
        expect(response.body).to include("Serie agregada exitosamente.")
    end
end
```

- Es importante mencionar que este test está hecho en base al codigo del controlador donde nosotros mismos definimos que si se guarda la instancia en el modelo se redirija a la vista `index`, sin embargo, en nigun momento estamos verificando que efectivamente se guardo en la base de datos, por lo que si el codigo en el controlador llegará a estar mal, el test pasaría de igual manera.

Finalmente, veremos un test con una solicitud **PATCH** para editar una instancia ya creada en la base de datos.

```ruby
describe "PATCH #update" do
    it "updates a specific serie and redirects" do
        serie = Serie.create({:nombre => "Test_serie", :puntuacion => 9, :comentario => "sjdosads"})
        patch serie_update_path(serie.id), :params => {:serie => {:nombre => "PhineasYFerb", :puntuacion => 9, :comentario => "Y perry?"}}
        expect(response).to be_redirect
    end
end
```

Podemos ver que es casi igual al test de post, solo que usamos el metodo `patch` y creamos una serie antes para poder editarla. En este caso solo verificamos que se redirija a cualquier vista por simplicidad.

### Te invito a que hagas el test con el metodo `patch` con mas detalle como se hizo arriba con el metodo `post` y que pruebes hacer _tests_ con el método `delete`. Además, recuerda ver la clase _rails, tests, html y css_ donde podrás encontrar más ejemplos!!
