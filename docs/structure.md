

# Folder structure
 > Note inspired by "end-it" on Reddit (https://www.reddit.com/r/godot/comments/7786ee/what_the_best_folder_structure_for_developement/)

```
/                       # --Project root
    /docs               # --Documentation (Markdown and Images)
    /entity             # --Entities
    /item               # --Item related stuff
    /menu               # --Standalone 2d menus or popups
    /scene              # --Full featured scenes
    /util               # --Utilities and globals that are used everywere
        /ui                 # --Reusable assets related to UI
    
    le_game.tcsn        # .The entry scene
    ui_theme.tres       # .The default ui theme
```