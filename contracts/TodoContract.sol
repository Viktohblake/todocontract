// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TodoContract {

    struct Todo {
        string title;
        string description;
        bool isDone;
    }

    Todo[] public todos;

    event TodoAdded(uint256 todoId, string _title, string _description);
    event TodoUpdated(uint256 todoId, string _updatedTitle, string _updatedDesc);
    event TodoCompleted(uint256 todoId, bool isDone);
    event TodoDeleted(uint256);

    function addTodo(string memory _title, string memory _description) public {
        todos.push(Todo(_title, _description, false));
        emit TodoAdded(todos.length -1, _title, _description);
    }

    function updateTodo(uint256 _todoId, string memory _updatedTitle, string memory _updatedDesc) public {
        require(_todoId < todos.length, "Todo item not found or existing!");
        todos[_todoId].title = _updatedTitle;
        todos[_todoId].description = _updatedDesc;
        emit TodoUpdated(_todoId, _updatedTitle, _updatedDesc);
    }

    function deleteTodo(uint256 _todoId) public {
        require(_todoId < todos.length, "Todo item not found or existing!");

         // Move the last task to the position of the deleted task
    todos[_todoId] = todos[todos.length - 1];

    // Remove the last element
    todos.pop();


        emit TodoDeleted(_todoId);
    }

    function getTodoLists() public view returns(Todo[] memory) {
        return todos;
    }
   
    function getTodo(uint8 _todoId) public view returns (string memory title, string memory description){
        require(_todoId < todos.length, "Todo item not found");
        Todo memory todo = todos[_todoId];
        return (todo.title, todo.description);
    } 
    
    function toggleIsDone(uint256 _todoId) public {
        require(_todoId < todos.length, "Todo item not found");
        todos[_todoId].isDone = !todos[_todoId].isDone;
        emit TodoCompleted(_todoId, todos[_todoId].isDone);
    }


}
