-ifndef(_topic_types_included).
-define(_topic_types_included, yeah).

-define(TOPIC_TOPICSTATE_UNPUBLISHED, 0).
-define(TOPIC_TOPICSTATE_PUBLISHED, 1).

%% struct 'Topic'

-record('Topic', {'id' :: integer(),
                  'url' :: string() | binary(),
                  'state' = 0 :: integer()}).
-type 'Topic'() :: #'Topic'{}.

-endif.
