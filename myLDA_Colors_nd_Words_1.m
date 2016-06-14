function [ WP,DP,Z,CP,CDP,Y ] = myLDA_Colors_nd_Words_1(WS,DS,CS,CDS,K,beta,gamma,WO)

%% Example 1 of running basic topic model (LDA)
%
% This example shows how to run the LDA Gibbs sampler on a small dataset to
% extract a set of topics and shows the most likely words per topic. It
% also writes the results to a file
startup;
%%
% Choose the dataset



%%
% Set the number of topics
T=K; 

%%
% Set the hyperparameters
BETA=beta;
GAMMA=gamma;
%ALPHA=10/T; % set less than 1
ALPHA=0.8;
%%
% The number of iterations
N = 300; 

%%
% The random seed
SEED = 3;

%%
% What output to show (0=no output; 1=iterations; 2=all output)
OUTPUT = 2;

%%
% This function might need a few minutes to finish
tic
[ WP,DP,Z,CP,CDP,Y ] = GibbsSamplerLDA_Colors_nd_Words_1(WS , DS , CS, CDS, T , N , ALPHA , BETA, GAMMA, SEED , OUTPUT );
toc

save './Results/myLDA_Colors_nd_Words_512' WP DP Z CP CDP Y;

% %%
% % Just in case, save the resulting information from this sample 
% if (dataset==1)
%     save 'ldasingle_psychreview' WP DP Z ALPHA BETA SEED N;
% end
% 
% if (dataset==2)
%     save 'ldasingle_nips' WP DP Z ALPHA BETA SEED N;
% end
% %%
% Put the most 7 likely words per topic in cell structure S
[S] = WriteTopics( WP , BETA , WO , 7 , 0.7 );

fprintf( '\n\nMost likely words in the first ten topics:\n' );

%%
% Show the most likely words in K topics
S( 1:K )  

%%
% Write the topics to a text file
WriteTopics( WP , BETA , WO , 30 , 0.7 , 4 , ['Results/topics_color_nd_word_512_K',num2str(K),'.txt'] );

fprintf( '\n\nInspect the file ''topics_color_nd_word_512.txt'' for a text-based summary of the topics\n' ); 