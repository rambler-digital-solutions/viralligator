-ifndef(_viralligator_types_included).
-define(_viralligator_types_included, yeah).

-define(VIRALLIGATOR_TOPICSTATE_UNPUBLISHED, 0).
-define(VIRALLIGATOR_TOPICSTATE_PUBLISHED, 1).

%% struct 'Topic'

-record('Topic', {'id' :: integer(),
                  'url' :: string() | binary(),
                  'state' = 0 :: integer(),
                  'sharings' :: dict:dict()}).
-type 'Topic'() :: #'Topic'{}.

%% struct 'Share'

-record('Share', {'social' :: string() | binary(),
                  'count' :: integer()}).
-type 'Share'() :: #'Share'{}.

%% struct 'Sharing'

-record('Sharing', {'url' :: string() | binary(),
                    'shares' :: list()}).
-type 'Sharing'() :: #'Sharing'{}.

-endif.
