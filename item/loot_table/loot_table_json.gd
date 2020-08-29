
class_name LootTableJSON

# {
#     "loot_tables": {
#         <loot_table_id>: [
#             {
#                 "name": <pool_name>,
#                 "entries": [
#                     {
#                         "type": ("item"|"loot_table"),
#                         "content_id": (<item_name>|<loot_table_id>),
#                         "chance": (0.0-1.0),
#                         "count_matrix": [<chance>, <count>]
#                     }
#                 ]
#             }
#         ]
#     }
# }

const ROOT_NAME = "loot_tables"

const POOL_NAME      = "name"
const POOL_ENTRIES   = "entries"

const ENTRY_TYPE         = "type"
const ENTRY_CONTENT_ID   = "content_id"
const ENTRY_CHANCE       = "chance"
const ENTRY_COUNT_MATRIX = "count_matrix"
