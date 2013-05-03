# TWKB (TaskWarriorKanbanBoard)

TWKB is a wrapper around [TaskWarrior](http://taskwarrior.org/projects/show/taskwarrior) that displays CLI kanban boards.

## Installation

```
gem install twkb
```

## Getting started
### Setting up a board
TWKB uses the UDA feature of TaskWarrior to display boards. The UDA used is 'board'. So make sure you have configured that UDA in your .taskrc:

```
uda.board.type=String
uda.board.label=Board
```

Next, make sure your tasks for the given board is tagged with the boardname you desire. The default board displayed is 'personal'. This can be done using task, e.g.: `task 1 modify board:work`.

### Setting up stages
A board consists of stages (columns in a table). The default stages are: backlog,next,inprogress, and waiting.

Lanes are also configured using UDA, using the 'stage' attribute, like so: `task add board:personal stage:backlog Do laundry`.

Again, remember to add the UDA to .taskrc:

```
uda.stage.type=string
uda.stage.label=Stage
uda.stage.values=backlog,next,inprogress,waiting
```

#### The 'Done' stage
A 'done' stage is automatically added, including the five most recent completed tasks.

### Displaying the board
Simply run `twkb` to display the default board (which is "personal"). You can specify an alternative board name as the first argument: `twkb work`.

That should get you started using twkb.

## Configuration
You can configure twkb using settings in .taskrc.

### twkb.view.cell_width (default '15')
Controls the width of each cell in the displayed table.

### twkb.view.stages.alignment (default 'center')
Controls the alignment of the headers of the table. See https://github.com/visionmedia/terminal-table#alignment.

### twkb.view.done_tasks (default '5')
Controls the number of tasks displayed in the 'Done' stage.

### twkb.stages (default 'backlog,next,inprogress,waiting,done')
Sets the stages shown in your boards.

### wkb.stages.<stage_name>.wip (default depends on stage)
The WIP limit of stage_name.

### twkb.stages.<stage_name>.label.value (default depends on stage)
The label showed in the header of the stage_name column.

## Author
Kim Nørgaard <jasen@jasen.dk>

## License
(The MIT License)

Copyright © 2008-2009 TJ Holowaychuk <tj@vision-media.ca>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, an d/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

