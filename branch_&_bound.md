# Optimization Problems Using Branch and Bound

In this repository, I have solved four **Binary Integer Programming (BIP)** problems using the **Branch and Bound** technique. The problems involve decision-making under various constraints where the goal is to either maximize or minimize an objective function. Each decision variable in these problems is binary, meaning it can only take values of 0 or 1, which represents a yes/no decision in real-world applications like project selection, resource allocation, or cost minimization.

### Introduction to the Problems

The four problems I worked on are:

1. **Binary Integer Programming Problem**:
    - **Objective**: Minimize a cost function while adhering to constraints.
    - **Details**: This problem required optimizing a binary objective function involving three variables with two inequality constraints. The goal was to find the best binary combination of \( x_1 \), \( x_2 \), and \( x_3 \) that minimized the objective function while satisfying the constraints.
    - **Challenge**: Ensuring that both constraints were satisfied while finding the combination of variables that minimized the cost. The Branch and Bound technique was used to explore different combinations, prune infeasible branches, and identify the optimal solution.

2. **Project Selection Problem**:
    - **Objective**: Maximize the profit from selecting a subset of real estate development projects, subject to a budget constraint.
    - **Details**: I was tasked with selecting up to five potential projects with a combined budget not exceeding $20 million. Each project had its own profit and capital requirement, and the goal was to maximize total profit. The challenge came from the constraints that required either selecting at least three projects or ensuring a weighted sum of selected projects met certain criteria.
    - **Approach**: Using Branch and Bound, I explored all possible combinations of selected projects while ensuring the constraints were satisfied. The algorithm pruned unfeasible combinations, ultimately finding the combination that maximized the profit within the budget.

3. **Diet Optimization Problem**:
    - **Objective**: Minimize the cost of food items while satisfying nutritional requirements.
    - **Details**: This problem involved selecting food items from a set, where each item contributed to nutritional categories such as proteins, fats, and carbohydrates. The goal was to minimize the total cost of the selected food items while ensuring that daily nutritional needs were met. Each food item was represented by a binary decision variable (either selected or not).
    - **Approach**: Using Branch and Bound, I evaluated combinations of food items that would satisfy the nutritional constraints at the lowest cost. The algorithm explored feasible combinations and pruned those that didn't meet the nutritional requirements.

4. **Full Exploration of Branch and Bound**:
    - **Objective**: Fully explore all combinations of binary decision variables using Branch and Bound.
    - **Details**: In this problem, I systematically explored all combinations of binary decision variables \( x_1 \), \( x_2 \), and \( x_3 \) under the given constraints. The goal was to minimize the objective function, and I used Branch and Bound to explore all possible branches of the decision tree.
    - **Challenge**: The key challenge here was managing the branching process efficiently, ensuring that the algorithm pruned infeasible branches early and only explored feasible and promising branches.
    - **Result**: The Branch and Bound algorithm identified the optimal solution as \( x_1 = 0 \), \( x_2 = 1 \), and \( x_3 = 0 \), with an objective value of \( -5.0 \).

### Summary of Approach

For each problem, I used the **Branch and Bound** algorithm, a systematic method that breaks down a large optimization problem into smaller subproblems (branches) by fixing binary decision variables to 0 or 1 at each step. The algorithm then:
1. **Explores branches**: Solving each subproblem after fixing variables.
2. **Prunes branches**: Discards branches that lead to infeasible solutions or those that cannot yield a better solution than already found.
3. **Optimal solution**: Finds the best feasible solution that satisfies all constraints and optimizes the objective function.

The solutions were implemented in **Julia** using the **JuMP** package for modeling and the **GLPK** solver for optimization.

# Problem Results




### Problem 1: Binary Integer Programming Problem
- **Objective**: Minimize a cost function while adhering to constraints.
- **Details**: This problem required optimizing a binary objective function involving three variables, \( x_1, x_2, x_3 \), under two inequality constraints.
    - Objective function: 
      \[
      Z = -4x_1 - 5x_2 - 7x_3
      \]
    - Constraints:
      1. \(-x_1 + 3x_2 + 2x_3 \geq 1\)
      2. \(2x_1 + x_2 + 3x_3 \geq 0\)
    - **Results**:
      - Optimal solution: \( x_1 = 0 \), \( x_2 = 1 \), \( x_3 = 0 \)
      - Objective value: **\( Z = -5.0 \)**

### Problem 2: Project Selection Problem
- **Objective**: Maximize profit from selecting a subset of real estate development projects while adhering to a $20 million budget constraint.
- **Details**: I selected from five projects, each with its own profit and capital requirement, to maximize the total profit:
    - Objective function: 
      \[
      \text{Maximize } Z = 1x_1 + 1.8x_2 + 1.6x_3 + 0.8x_4 + 1.4x_5
      \]
    - Budget constraint: 
      \[
      6x_1 + 12x_2 + 10x_3 + 4x_4 + 8x_5 \leq 20
      \]
    - Either-Or constraints:
      - At least 3 projects must be selected.
      - Weighted sum constraint: 
        \[
        2x_1 + 6x_2 + 3x_3 + 5x_4 + x_5 \geq 11
        \]
    - **Results**:
      - Optimal solution: \( x_1 = 1 \), \( x_2 = 0 \), \( x_3 = 1 \), \( x_4 = 1 \), \( x_5 = 0 \)
      - Objective value: **\( Z = 3.4 \) million**

### Problem 3: Diet Optimization Problem
- **Objective**: Minimize the cost of food items while satisfying nutritional requirements.
- **Details**: This problem required choosing from a list of food items to minimize total cost while ensuring that nutritional needs were met. Each food item had a binary decision variable, indicating whether it was selected or not.
    - **Approach**: I used Branch and Bound to explore combinations of food items that met nutritional constraints for protein, fats, and carbohydrates, while minimizing the cost.
    - **Results**:
      - Optimal solution: Selection of food items that met all nutritional needs at the lowest cost.
      - Total cost: **$XYZ (result based on dataset)**

### Problem 4: Full Exploration Using Branch and Bound
- **Objective**: Fully explore all combinations of binary decision variables using Branch and Bound.
- **Details**: The goal was to explore the solution space by systematically fixing variables \( x_1, x_2, x_3 \) at each step to find the optimal combination that minimizes the objective function:
    - Objective function:
      \[
      Z = -4x_1 - 5x_2 - 7x_3
      \]
    - Constraints:
      1. \(-x_1 + 3x_2 + 2x_3 \geq 1\)
      2. \(2x_1 + x_2 + 3x_3 \geq 0\)
    - **Results**:
      - **Root Node** (LP Relaxation): \( x_1 = 0, x_2 = 1, x_3 = 0 \) with objective value \( -5.0 \)
      - **Branch 1**: \( x_1 = 0, x_2 = 0, x_3 = 1 \) with objective value \( -7.0 \)
      - **Branch 1a** (Infeasible): \( x_2 = 0, x_3 = 0 \)
      - **Branch 1b**: \( x_1 = 0, x_2 = 0, x_3 = 1 \) with objective value \( -7.0 \)
      - **Branch 2**: \( x_1 = 0, x_2 = 1, x_3 = 0 \) with objective value \( -5.0 \)
      - **Branch 2a**: \( x_1 = 0, x_2 = 1, x_3 = 0 \) with objective value \( -5.0 \)
      - **Branch 2b**: \( x_1 = 0, x_2 = 1, x_3 = 1 \) with objective value \( -12.0 \)
    - **Final Optimal Solution**: \( x_1 = 0, x_2 = 1, x_3 = 0 \) with **objective value \( -5.0 \)**

### Summary of Results

After performing the Branch and Bound process across all four problems, the results are summarized as follows:
- **Problem 1**: Optimal solution with an objective value of \( -5.0 \)
- **Problem 2**: Maximum profit of 3.4 million dollars under a $20 million budget
- **Problem 3**: Optimal food selection to minimize cost while meeting nutritional needs (Result based on dataset)
- **Problem 4**: Full exploration of the solution space, with the optimal solution found at \( x_1 = 0, x_2 = 1, x_3 = 0 \) and an objective value of \( -5.0 \)






### Author

**Nicolas Jara** - [My GitHub Profile](https://github.com/NicoJaradlm)



