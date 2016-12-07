-ifndef(_viralligator_types_included).
-define(_viralligator_types_included, yeah).

%% struct 'Share'

-record('Share', {'social' :: string() | binary(),
                  'count' :: integer()}).
-type 'Share'() :: #'Share'{}.

%% struct 'TotalShare'

-record('TotalShare', {'url' :: string() | binary(),
                       'count' :: integer()}).
-type 'TotalShare'() :: #'TotalShare'{}.

%% struct 'Sharing'

-record('Sharing', {'url' :: string() | binary(),
                    'shares' :: list()}).
-type 'Sharing'() :: #'Sharing'{}.

-endif.
