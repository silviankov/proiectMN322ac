function createWindow(matErr, matVec_proprii, tolerance, vec_propriu)

%%Test variables:
% tolerance = 0.05;                                                  %tolerance
% iter = 50;                                                   %Iterations
% A = [ 1 , 2 , 3 ];                                           %Initial vector coordinates
% Target = [ 6 , 3 , 2 ];                                      %Target vector
% 
% matErr( 1 ) = 1;                                              %matErr vector initialiser
% for i = 2 : iter
%     matErr( i ) = matErr( i-1 ) - 1/100 * i;                   %String containing matErr at each iteration. < Accessible through matErr( iterNo ) >
% end
% 
% for i = 1 : 3
%     matVec_proprii( i ) = A( i );                                    %Test matVec_proprii of vectors intiliasier
% end
% 
% for i = 2 : iter
%         for j = 1 : 3
%             matVec_proprii( i , j ) = ( i * ( 1 / 10 ) ) + A( j );   %Vector coordinates on each iteration. < Accessible through matVec_proprii( iterNo , : ) >
%         end
% end

%% Receiving input
iterations = length(matErr);
Target = vec_propriu;

%% Create draw window based on screen size
scrnsz = get ( groot , 'ScreenSize' );
fig = figure ( 'Visible' , 'off' , 'Position' , [ scrnsz(3)/4 0 scrnsz(3)/2 scrnsz(4) ] , 'NumberTitle' , 'off' , 'Name' , ...
               'Reverse Power Method' , 'ToolBar' , 'none' , 'Color' , 'b' , 'MenuBar' , 'none');
           
%% Horizontal control slider
slider = uicontrol ( 'Parent' , fig , 'Style' , 'slider' , 'Units' , 'normalized' , 'Position' , [ 0.55 0.40 0.35 0.02 ] ,...
                     'min' , 1 , 'max' , iterations , 'Value' , 1 , ... 
                     'SliderStep' , [ 1/(iterations-1) , 1/(iterations-1) ] , 'CallBack' , {@slider_callback} ); 
TitleBoxSlider = annotation ( 'textbox' );
set ( TitleBoxSlider , 'FontSize' , 20 , 'String' , 'Iteration selector' , 'Position' , [ 0.65 0.37 0.1 0.1 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'red' );
TextBoxSlider = annotation ( 'textbox' );
set ( TextBoxSlider , 'FontSize' , 20 , 'String' , [ num2str(1) ], 'Position' , [ .91 .41 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );
              
function slider_callback( source , ~ )
    
    t = floor( get ( source , 'Value' ) );
    %% 2D plots reinitialise
    axes(axXY);
    vXY = [ matVec_proprii( t , 1 ) , matVec_proprii( t , 2 ) ; Target( 1 ) , Target( 2 )];
    plot ( axXY , [ 0 , 0 ] );
    hold on;
    quiver ( axXY , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( t , 1 ) , Target( 1 ) ] , [ matVec_proprii( t , 2 ) , Target( 2 ) ] , 0 );
    %patch( axXY , 'Vertices' , vXY , 'FaceColor' , 'red' , 'FaceAlpha' , .2 );
    title( '\color{Red}XY Plot' );
    hold off;
    
    axes(axXZ);
    vXZ = [ matVec_proprii( t , 1 ) , matVec_proprii( t , 3 ) ; Target( 1 ) , Target( 3 ) ];
    plot ( axXZ , [ 0 , 0 ] );
    hold on;
    %patch( axXZ , 'Vertices' , vXZ , 'FaceColor' , 'red' , 'FaceAlpha' , .2 );
    quiver ( axXZ , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( t , 1 ) , Target( 1 ) ] , [ matVec_proprii( t , 3 ) , Target( 3 ) ] );
    title( '\color{Red}XZ Plot' );
    hold off;
    
    axes(axYZ);
    vYZ = [ matVec_proprii( t , 2 ) , matVec_proprii( t , 3 ) ; Target( 2 ) , Target( 3 ) ];
    plot ( axYZ , [ 0 , 0 ] );
    hold on;
    quiver ( axYZ , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( t , 2 ) , Target( 2 ) ] , [ matVec_proprii( t , 3 ) , Target( 3 ) ] );
    %patch ( axYZ , 'Vertices' , vYZ , 'FaceColor' , 'red' , 'FaceAlpha' , .2 );
    title( '\color{Red}YZ Plot' );
    hold off;
    
    %% 3D plot reinitialise
    axes(ax3d);
    quiver3 ( [ 0 , 0 ] , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( t , 1 ) , Target( 1 ) ] , [ matVec_proprii( t , 2 ) , Target( 2 ) ] ,...
              [ matVec_proprii( t , 3 ) , Target( 3 ) ] , 0 );
    title( '\color{Red}3D Plot' );
    
    %% Error plot reinitialise
    axes(axErr);
    plot ( axErr , matErr(1:t) , '-*' );
    set( gca , 'XTick' , 0:5:iterations );
    title( '\color{Red}Error' );
    
    %% Vector display reinitialise
    set ( TextBoxVect , 'FontSize' , 20 , 'String' , [ 'Vector:  ' , num2str( matVec_proprii( t , 1 ) ), '  ' , num2str( matVec_proprii( t , 2 ) ), '  ' ,...
        num2str( matVec_proprii( t , 3) ) ] , 'Position' , [ .05 .3 .5 .025 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
    
    %% Iteration textbox update
    set ( TextBoxSlider , 'FontSize' , 20 , 'String' , [ num2str(t) ], 'Position' , [ .91 .41 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

end

%% 3D plot viewpoint slider
slider3D = uicontrol ( 'Parent' , fig , 'Style' , 'slider' , 'Units' , 'normalized' , 'Position' , [ 0.05 0.40 0.35 0.02 ] , ...
                       'min' , 1 , 'max' , 4 , 'Value' , 1 , ...
                       'SliderStep' , [ 1/4 , 1/4 ] , 'CallBack' , {@slider3d_callback} );
TitleBoxSlider3D = annotation ( 'textbox' );
set ( TitleBoxSlider3D , 'FontSize' , 20 , 'String' , 'Viewpoint selector' , 'Position' , [ 0.15 0.37 0.1 0.1 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'red' );
TextBoxSlider3D = annotation ( 'textbox' );
set ( TextBoxSlider3D , 'FontSize' , 20 , 'String' , [ num2str(1) ], 'Position' , [ .41 .41 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

function slider3d_callback( source , ~ )
    viewpoint = floor ( get ( source , 'Value' ) );set ( TextBoxSlider3D , 'FontSize' , 20 , 'String' , [ num2str(viewpoint) ], 'Position' , [ .41 .41 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );
    
    if viewpoint == 1
        set( ax3d.Title , 'String' , '\color{Red}3D Plot : Default viewpoint' );
        view( ax3d , 3);
    else if viewpoint == 2
            set( ax3d.Title , 'String' , '\color{Red}3D Plot : XZ viewpoint' );
            view( ax3d , [ 0 0 ] );
        else if viewpoint == 3
                set( ax3d.Title , 'String' , '\color{Red}3D Plot : XY viewpoint' );
                view( ax3d , [ 0 90 ] );
            else if viewpoint == 4
                    set( ax3d.Title , 'String' , '\color{Red}3D Plot : YZ viewpoint' );
                    view( ax3d , [ 90 0 ] ); 
                end
            end
        end
    end
end

%% Lower Left text boxes
TextBoxtolerance = annotation ( 'textbox' );
set ( TextBoxtolerance , 'FontSize' , 20 , 'String' , [ 'tolerance: ' , num2str(tolerance)  ], 'Position' , [ .05 .15 .5 .025 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

TextBoxIter = annotation ( 'textbox' );
set ( TextBoxIter , 'FontSize' , 20 , 'String' , [ 'Iterations required: ' , num2str(iterations-1) ] , 'Position' , [ .05 .1 .5 .025 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

%% Create a 2D plot of vertices with a patch for the ErrorArea and a Vertex representing the Error
%XY plot
axXY = axes('Units','normal','Position',[ .55 .75 .4 .2 ]);
vXY = [ matVec_proprii( 1 , 1 ) , matVec_proprii( 1 , 2 ) ; Target( 1 ) , Target( 2 ) ; 0 , 0];
quiver ( axXY , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( 1 , 1 ) , Target( 1 ) ] , [ matVec_proprii( 1 , 2 ) , Target( 2 ) ] , 0 );
hold on;
patch( axXY , 'Vertices' , vXY , 'FaceColor' , 'red' , 'FaceAlpha' , .2 );
title('\color{Red}XY Plot');
hold off;

%XZ plot
axXZ = axes('Units','normal','Position',[ .05 .50 .4 .2 ]);
vXZ = [ matVec_proprii( 1 , 1 ) , matVec_proprii( 1 , 3 ) ; Target( 1 ) , Target( 3 ) ; 0 , 0];
hold on;
patch( axXZ , 'Vertices' , vXZ , 'FaceColor' , 'green' , 'FaceAlpha' , .2 );
quiver ( axXZ , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( 1 , 1 ) , Target( 1 ) ] , [ matVec_proprii( 1 , 3 ) , Target( 3 ) ] , 0 );
title('\color{Red}XZ Plot');
hold off;

%YZ plot
axYZ = axes('Units','normal','Position',[ .55 .50 .4 .2 ]);
vYZ = [ matVec_proprii( 1 , 2 ) , matVec_proprii( 1 , 3 ) ; Target( 2 ) , Target( 3 ) ; 0 , 0];
hold on;
patch( axYZ , 'Vertices' , vYZ , 'FaceColor' , 'yellow' , 'FaceAlpha' , .2 );
quiver ( axYZ , [ 0 , 0 ] , [ 0 , 0 ] , [ matVec_proprii( 1 , 2 ) , Target( 2 ) ] , [ matVec_proprii( 1 , 3 ) , Target( 3 ) ] , 0 );
title('\color{Red}YZ Plot');
hold off;

%% 3D plot
ax3d = axes('Units','normal','Position',[ .05 .75 .4 .2 ]);
quiver3( [ 0 , 0 ] , [ 0 , 0 ] , [ 0 , 0 ] , [ A( 1 ) , Target( 1 ) ] , [ A( 2 ) , Target( 2 ) ] , [ A( 3 ) , Target( 3 ) ] , 0 );
title('\color{Red}3D Plot : Default viewpoint');

%% Display matErr plot
axErr = axes('Units','normal','Position',[ .55 .05 .4 .25 ]);
plot ( axErr , matErr , '-*' );
set( gca , 'XTick' , 0:5:iterations );
title('\color{Red}Error');

%% Display actual vector
TextBoxVect = annotation ( 'textbox' );
set ( TextBoxVect , 'FontSize' , 20 , 'String' , [ 'Vector: ' , num2str( matVec_proprii( 1 , 1 ) ), ' ' , num2str( matVec_proprii( 1 , 2 ) ), ' ' , num2str( matVec_proprii( 1 , 3) ) ] ,...
      'Position' , [ .05 .3 .5 .025 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );

  %% Display target vector
TextBoxTarget = annotation ( 'textbox' );
set ( TextBoxTarget , 'FontSize' , 20 , 'String' , [ 'Target: ' , num2str( Target( 1 ) ), ' ' , num2str( Target( 2 ) ), ' ' , num2str( Target( 3 ) ) ] ,...
      'Position' , [ .05 .35 .5 .025 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );


%% GUI Visibility
set ( fig , 'Visible' , 'on' );

end
