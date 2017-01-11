function createWindowN(dim)



%%Test variables:
tol = 0.05;                                                  %Tolerance
iter = 50;                                                   %Iterations
for i = 1 : dim
    A( i ) = i;                                              %Initial vector coordinates
end

for i = 1 : dim
    Target( i ) = i*3 ;                                        %Target vector
end

for i = 1 : dim
    Matrix( 1 , i ) = A( i );                                %Test matrix of vectors initialiser             
end


for i = 2 : iter
    for j = 1 : dim
        Matrix( i , j ) = A( j ) + ( i * ( 1 / 10 ) );                            %Vector coordinates on each iteration. < Accessible through Matrix( iterNo , : ) >
    end
end

error( 1 ) = 1;                                              %error vector initialiser
for i = 2 : iter
    error( i ) = error( i-1 ) - 1/100 * i;                   %String containing error at each iteration. < Accessible through error( iterNo ) >
end

%% Create draw window based on screen size
scrnsz = get ( groot , 'ScreenSize' );
fig = figure ( 'Visible' , 'on' , 'Position' , [ scrnsz(3)/4 0 scrnsz(3)/2 scrnsz(4) ] , 'NumberTitle' , 'off' , 'Name' , ...
               'Reverse Power Method' , 'ToolBar' , 'none' , 'Color' , 'b' , 'MenuBar' , 'none');
           
%% Horizontal control slider
slider = uicontrol ( 'Parent' , fig , 'Style' , 'slider' , 'Units' , 'normalized' , 'Position' , [ 0.55 0.60 0.35 0.02 ] ,...
                     'min' , 1 , 'max' , iter , 'Value' , 1 , ... 
                     'SliderStep' , [ 1/(iter-1) , 1/(iter-1) ] , 'CallBack' , {@slider_callback} ); 
TitleBoxSlider = annotation ( 'textbox' );
set ( TitleBoxSlider , 'FontSize' , 20 , 'String' , 'Iteration selector' , 'Position' , [ 0.65 0.61 0.1 0.1 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'red' );
TextBoxSlider = annotation ( 'textbox' );
set ( TextBoxSlider , 'FontSize' , 20 , 'String' , [ num2str(1) ], 'Position' , [ .91 .61 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );
  
function slider_callback( source , data )
    
     t = floor( get ( source , 'Value' ) );
     set( mtxSlider , 'Value' , 1 );
     set ( TitleBoxVect , 'FontSize' , 30 , 'String' , [ 'Vector columns ' , num2str(1), ' through ' , num2str(3) ] ,...
      'Position' , [ .05 .91 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
     
     %% Error plot reinitialise
     axes(axErr);
     plot ( axErr , error(1:t) , '-*' );
     set( gca , 'XTick' , 0:5:iter );
     title( '\color{Red}Error' );
     
     %% Vector display update
     set ( TextBoxVect , 'FontSize' , 40 , 'String' , [ 'Vector: ' , num2str( Matrix( t , 1 ) ), ' ' , num2str( Matrix( t , 2 ) ), ' ' , num2str( Matrix( t , 3) ) ] ,...
      'Position' , [ .05 .85 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
    
     %% Iteration textbox update
     set ( TextBoxSlider , 'FontSize' , 20 , 'String' , [ num2str(t) ], 'Position' , [ .91 .61 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );
     
end

%% Matrix viewpoint slider

mtxSlider = uicontrol( 'Parent' , fig , 'Style' , 'slider' , 'Units' , 'normalized' , 'Position' , [ 0.05 0.6 0.35 0.02 ] , ...
                       'min' , 1 , 'max' , dim-2 , 'Value' , 1 , ...
                       'SliderStep' , [ 1/(dim) , 1/(dim) ] , 'CallBack' , {@mtxSlider_callback} );

function mtxSlider_callback( source , data )

    t = floor ( get ( source , 'Value' ) );
    line = floor ( get ( slider , 'Value' ) );
    %% Actual vector display update
    set ( TextBoxVect , 'FontSize' , 40 , 'String' , [ 'Vector: ' , num2str( Matrix( line , t ) ), ' ' , num2str( Matrix( line , t+1 ) ), ' ' , num2str( Matrix( line , t+2 ) ) ] ,...
      'Position' , [ .05 .85 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
    set ( TitleBoxVect , 'FontSize' , 30 , 'String' , [ 'Vector columns ' , num2str(t), ' through ' , num2str(t+2) ] ,...
      'Position' , [ .05 .91 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
end

%% Display error plot
axErr = axes('Units','normal','Position',[ .35 .05 .6 .5 ]);
plot ( axErr , error , '-*' );
set( gca , 'XTick' , 0:5:iter );
title('\color{Red}Error' , 'FontSize' , 20);

%% Display actual vector
TextBoxVect = annotation ( 'textbox' );
set ( TextBoxVect , 'FontSize' , 40 , 'String' , [ 'Vector: ' , num2str( Matrix( 1 , 1 ) ), ' ' , num2str( Matrix( 1 , 2 ) ), ' ' , num2str( Matrix( 1 , 3) ) ] ,...
      'Position' , [ .05 .85 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
TitleBoxVect = annotation ( 'textbox' );
set ( TitleBoxVect , 'FontSize' , 30 , 'String' , [ 'Vector columns ' , num2str(1), ' through ' , num2str(3) ] ,...
      'Position' , [ .05 .91 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
  %% Display target vector
TextBoxTarget = annotation ( 'textbox' );
set ( TextBoxTarget , 'FontSize' , 40 , 'String' , [ 'Target: ' , num2str( Target( 1 ) ), ' ' , num2str( Target( 2 ) ), ' ' , num2str( Target( 3 ) ) ] ,...
      'Position' , [ .05 .75 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );

  %% Lower Left text boxes
TextBoxTol = annotation ( 'textbox' );
set ( TextBoxTol , 'FontSize' , 20 , 'String' , [ 'Tolerance: ' , num2str(tol)  ], 'Position' , [ .05 .15 .5 .025 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

TextBoxIter = annotation ( 'textbox' );
set ( TextBoxIter , 'FontSize' , 20 , 'String' , [ 'Iterations required: ' , num2str(iter) ] , 'Position' , [ .05 .1 .5 .025 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

  
end