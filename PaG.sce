//Conversion txt a matrices
clear all
xdel(winsid())
clc
    //El txt. contendra los datos de cada variable en una columna, cada columna
    //separada por una tabulacion. Decimales separados por punto. Ninguna
    //linea vacia y ningun texto permitidos.
    //Cambiar variables indicadas por *

//*Direccion de los archivos, incluir '.txt'
    //Abrir el explorador de archivos de Scilab en la carpeta contenedora de los
        //.txt y el .sce, o escribir la direccion completa del archivo.
        //Si no hay segunda tabla, dejar el valor a 0
tabla1 = 'medidas1_2.txt';
tabla2 = 'medidas2.txt';

// Conversion medidas a matrices
m1 = fscanfMat(tabla1);
if tabla2 ~= 0 then
    m2 = fscanfMat(tabla2);
end

// Escala de tiempo: Tm = 0.5s, nº medidas = 492
Tm = 0.5;           //*Tiempo de muestreo

tmax1 = max(size(m1))/2 - 0.5;  //Numero de medidas
t1 = 0:Tm:tmax1;    //Escala de tiempos grafica 1

if tabla2 ~= 0 then
    tmax2 = max(size(m2))/2 - 0.5;  //Numero de medidas
    t2 = 0:Tm:tmax2;    //Escala de tiempos grafica 2
end

//*Referencias (Si no se desea, dejar a 0)
Ref1 = 0;
Ref2 = 0;

//Graficas
    //*¿Unir puntos con lineas? 1/0
lineas = 1;
    //*¿Puntos huecos? 1/0
hueco = 1;
    //*¿Solo lineas? 1/0
no_h = 1;
    //*¿Cuadricula? 1/0
cuad = 0;
    //*¿Blanco y negro? 1/0 (cambia los punteros de cada variable para poder
    //distinguir en papel impreso)
byn = 1;

    //Numero de columnas por grafica
ncol_1 = min(size(m1));
if tabla2 ~= 0 then
    ncol_2 = min(size(m2));
end

    //*Nombres de las variables, titulos y ejes por tabla (que coincidan con ncol_#)
Tit_1 = 'Medidas1';
Nom_1 = ['RTD 4-term','Termopar varilla','RTD 3-term'];
x_1 = 't (s)';
y_1 = 'T (ºC)';
if tabla2 ~= 0 then
    Tit_2 = 'Medidas2';
    Nom_2 = ['RTD 4-term','Termopar varilla','Termopar 2'];
    x_2 = 't (s)';
    y_2 = 'T (ºC)';
end

    //Colores de cada variable
col = ['r','g','b'];
linea = ['-','-.','--'];

    //Estilos de los punteros
sty = [9,2,6,11,10,14,1,7,0,5];

frmt = '.';
if hueco then
    frmt = 'o';
end
if lineas then
    frmt = strcat(['-',frmt]);
end

figure('BackgroundColor',[1 1 1]);
for i=1:ncol_1
    if no_h & byn then
        frmt = linea(i);
        col(i) = 'k';
    end
    plot(t1*Tm,m1(:,i)',strcat([col(i),frmt]));
    h = get("hdl");
    h = h.children;
    h.mark_size=4;
    if byn then
        h.mark_style=sty(i);
    end
    if no_h then
        h.mark_mode = 'off';
        h.thickness = 2;
    end
end

legend(Nom_1,2);

if Ref1>0 then
    plot(t1*Tm,Ref1*ones(t1),'k');
    legend(Nom_1,'Ref',2);
end

if cuad then
    xgrid;
end

if byn then
    a = get('current_axes');
    a.font_size = 3;
    a.x_label.font_size = 3;
    a.y_label.font_size = 3;
    c1 = a.children(2).children(1);
    c2 = a.children(3).children(1);
    c3 = a.children(4).children(1);
    c1.thickness = 2;
    c2.thickness = 2;
    c3.thickness = 2;
end

xtitle(Tit_1,x_1,y_1);
title(Tit_1,'font_size',4,'font_style',4);

if tabla2 ~= 0 then
    figure('BackgroundColor',[1 1 1]);
    for i=1:ncol_2
                if no_h & byn then
            frmt = linea(i);
        end
        plot(t2*Tm,m2(:,i)',strcat([col(i),frmt]));
        h = get("hdl");
        h = h.children;
        h.mark_size=4;
        if byn then
            h.mark_style=sty(i);
        end
        if no_h then
            h.mark_mode = 'off';
            h.thickness = 2;
        end
    end

    legend(Nom_2,2);

    if Ref2>0 then
        plot(t2*Tm,Ref2*ones(t2),'k');
        legend(Nom_2,'Ref',2);
    end

    if cuad then
        xgrid;
        'hi'
    end

    xtitle(Tit_2,x_2,y_2);
    title(Tit_2,'font_size',4,'font_style',4);
end

if byn then
    a = get('current_axes');
    a.font_size = 3;
    a.x_label.font_size = 3;
    a.y_label.font_size = 3;
    c1 = a.children(2).children(1);
    c2 = a.children(3).children(1);
    c3 = a.children(4).children(1);
    c1.thickness = 2;
    c2.thickness = 2;
    c3.thickness = 2;
end
