function createWindowN(matErr, matVec_proprii, tolerance, vec_propriu)

%%Test variables:
% tolerance = 0.05;                                                  %Tolerance
% iterations = 50;                                                   %Iterations
% for i = 1 : dim
%     A( i ) = i;                                              %Initial vector coordinates
% end
% 
% for i = 1 : dim
%     Target( i ) = i*3 ;                                        %Target vector
% end
% 
% for i = 1 : dim
%     matVec_proprii( 1 , i ) = A( i );                                %Test matVec_proprii of vectors initialiser             
% end
% 
% 
% for i = 2 : iterations
%     for j = 1 : dim
%         matVec_proprii( i , j ) = A( j ) + ( i * ( 1 / 10 ) );                            %Vector coordinates on each iteration. < Accessible through matVec_proprii( iterNo , : ) >
%     end
% end
% 
% matErr( 1 ) = 1;                                              %matErr vector initialiser
% for i = 2 : iterations
%     matErr( i ) = matErr( i-1 ) - 1/100 * i;                   %String containing matErr at each iteration. < Accessible through matErr( iterNo ) >
% end

%% Receiving input
iterations = length(matErr);
dim = length(matVec_proprii(1,:));
Target = vec_propriu;

%% Create draw window based on screen size
scrnsz = get ( groot , 'ScreenSize' );
fig = figure ( 'Visible' , 'on' , 'Position' , [ scrnsz(3)/4 0 scrnsz(3)/2 scrnsz(4) ] , 'NumberTitle' , 'off' , 'Name' , ...
               'Reverse Power Method' , 'ToolBar' , 'none' , 'Color', 'y', 'MenuBar' , 'none');
           
%% Horizontal control slider
slider = uicontrol ( 'Parent' , fig , 'Style' , 'slider' , 'Units' , 'normalized' , 'Position' , [ 0.55 0.60 0.35 0.02 ] ,...
                     'min' , 1 , 'max' , iterations , 'Value' , 1 , ... 
                     'SliderStep' , [ 1/(iterations-1) , 1/(iterations-1) ] , 'CallBack' , {@slider_callback} ); 
TitleBoxSlider = annotation ( 'textbox' );
set ( TitleBoxSlider , 'FontSize' , 20 , 'String' , 'Iteration selector' , 'Position' , [ 0.65 0.61 0.1 0.1 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'red' );
TextBoxSlider = annotation ( 'textbox' );
set ( TextBoxSlider , 'FontSize' , 20 , 'String' , [ num2str(1) ], 'Position' , [ .91 .61 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );
  
function slider_callback( source , data )
    
     t = floor( get ( source , 'Value' ) );
     set( mtxSlider , 'Value' , 1 );
     set ( TitleBoxVect , 'FontSize' , 20 , 'String' , [ 'Vector columns ' , num2str(1), ' through ' , num2str(3) ] ,...
      'Position' , [ .05 .91 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
     
     %% Error plot reinitialise
     axes(axErr);
     plot ( axErr , matErr(1:t) , '-*' );
     set( gca , 'XTick' , 0:5:iterations );
     title( '\color{Red}Error' );
     
     %% Vector display update
     set ( TextBoxVect , 'FontSize' , 20 , 'String' , [ 'Vector: ' , num2str( matVec_proprii( t , 1 ) ), ' ' , num2str( matVec_proprii( t , 2 ) ), ' ' , num2str( matVec_proprii( t , 3) ) ] ,...
      'Position' , [ .05 .85 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
    
     %% Iteration textbox update
     set ( TextBoxSlider , 'FontSize' , 20 , 'String' , [ num2str(t) ], 'Position' , [ .91 .61 .3 .02 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );
     
end

%% matVec_proprii viewpoint slider

mtxSlider = uicontrol( 'Parent' , fig , 'Style' , 'slider' , 'Units' , 'normalized' , 'Position' , [ 0.05 0.6 0.35 0.02 ] , ...
                       'min' , 1 , 'max' , dim-2 , 'Value' , 1 , ...
                       'SliderStep' , [ 1/(dim) , 1/(dim) ] , 'CallBack' , {@mtxSlider_callback} );

function mtxSlider_callback( source , data )

    t = floor ( get ( source , 'Value' ) );
    line = floor ( get ( slider , 'Value' ) );
    %% Actual vector display update
    set ( TextBoxVect , 'FontSize' , 20 , 'String' , [ 'Vector: ' , num2str( matVec_proprii( line , t ) ), ' ' , num2str( matVec_proprii( line , t+1 ) ), ' ' , num2str( matVec_proprii( line , t+2 ) ) ] ,...
      'Position' , [ .05 .85 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
    set ( TextBoxTarget , 'FontSize' , 20 , 'String' , [ 'Target ' , num2str( vec_propriu( t ) ), ' ' , num2str( vec_propriu( t+1 ) ), ' ' , num2str( vec_propriu( t+2 ) ) ] ,...
      'Position' , [ .05 .75 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
    set ( TitleBoxVect , 'FontSize' , 30 , 'String' , [ 'Vector columns ' , num2str(t), ' through ' , num2str(t+2) ] ,...
      'Position' , [ .05 .91 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
end

%% Display matErr plot
axErr = axes('Units','normal','Position',[ .35 .05 .6 .5 ]);
plot ( axErr , matErr , '-*' );
set( gca , 'XTick' , 0:5:iterations );
title('\color{Red}Error' , 'FontSize' , 20);

%% Display actual vector
TextBoxVect = annotation ( 'textbox' );
set ( TextBoxVect , 'FontSize' , 20 , 'String' , [ 'Vector: ' , num2str( matVec_proprii( 1 , 1 ) ), ' ' , num2str( matVec_proprii( 1 , 2 ) ), ' ' , num2str( matVec_proprii( 1 , 3) ) ] ,...
      'Position' , [ .05 .85 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
TitleBoxVect = annotation ( 'textbox' );
set ( TitleBoxVect , 'FontSize' , 30 , 'String' , [ 'Vector columns ' , num2str(1), ' through ' , num2str(3) ] ,...
      'Position' , [ .05 .91 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );
  %% Display target vector
TextBoxTarget = annotation ( 'textbox' );
set ( TextBoxTarget , 'FontSize' , 20 , 'String' , [ 'Target: ' , num2str( Target( 1 ) ), ' ' , num2str( Target( 2 ) ), ' ' , num2str( Target( 3 ) ) ] ,...
      'Position' , [ .05 .75 .5 .04 ] , 'EdgeColor' , 'none' , 'Color' , 'r' );

  %% Lower Left text boxes
TextBoxTol = annotation ( 'textbox' );
set ( TextBoxTol , 'FontSize' , 20 , 'String' , [ 'Tolerance: ' , num2str(tolerance)  ], 'Position' , [ .05 .15 .5 .025 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

TextBoxIter = annotation ( 'textbox' );
set ( TextBoxIter , 'FontSize' , 20 , 'String' , [ 'Iterations required: ' , num2str(iterations-1) ] , 'Position' , [ .05 .1 .5 .025 ] ,...
      'EdgeColor' , 'none' , 'Color' , 'r' );

  
end