using JuMP, GLPK

# Create model
model = Model(GLPK.Optimizer)

# Decision variables
@variable(model, x11 >= 0)
@variable(model, x12 >= 0)
@variable(model, x21 >= 0)
@variable(model, x22 >= 0)
@variable(model, y1, Bin) # Binary variable for selecting factory for toy 1
@variable(model, y2, Bin) # Binary variable for selecting factory for toy 2

# Objective function: Maximize profit
@objective(model, Max, 10*(x11 + x12) + 15*(x21 + x22) - 50000*y1 - 80000*y2)

# Constraints
M = 1e6  # A sufficiently large number for binary factory selection constraints

# Time constraints for factories
@constraint(model, x11 / 50 <= 500)  # Factory 1, toy 1 production constraint
@constraint(model, x12 / 40 <= 700)  # Factory 2, toy 1 production constraint
@constraint(model, x21 / 40 <= 500)  # Factory 1, toy 2 production constraint
@constraint(model, x22 / 25 <= 700)  # Factory 2, toy 2 production constraint

# Factory selection constraints (either one factory or the other for each toy)
@constraint(model, x11 <= y1 * M)
@constraint(model, x12 <= (1 - y1) * M)
@constraint(model, x21 <= y2 * M)
@constraint(model, x22 <= (1 - y2) * M)

# Solve the model
optimize!(model)

# Results
println("Optimal toy 1 production in factory 1: ", value(x11))
println("Optimal toy 1 production in factory 2: ", value(x12))
println("Optimal toy 2 production in factory 1: ", value(x21))
println("Optimal toy 2 production in factory 2: ", value(x22))
println("Factory selected for toy 1: ", value(y1) == 1 ? "Factory 1" : "Factory 2")
println("Factory selected for toy 2: ", value(y2) == 1 ? "Factory 1" : "Factory 2")
println("Maximum profit: ", objective_value(model))



#Problem 2
using JuMP, GLPK

# Create model
model = Model(GLPK.Optimizer)

# Decision variables: binary variables for selecting routes
@variable(model, x[1:10], Bin)

# Objective function: Minimize total delivery time
@objective(model, Min, 6*x[1] + 4*x[2] + 7*x[3] + 5*x[4] + 4*x[5] + 6*x[6] + 5*x[7] + 3*x[8] + 7*x[9] + 6*x[10])

# Constraints: Each delivery location should be covered exactly once
@constraint(model, x[1] + x[5] + x[9] == 1)   # Location A
@constraint(model, x[2] + x[4] + x[6] + x[9] + x[10] == 1)  # Location B
@constraint(model, x[3] + x[4] + x[7] + x[9] == 1)   # Location C
@constraint(model, x[1] + x[6] + x[8] == 1)   # Location D
@constraint(model, x[3] + x[4] + x[6] == 1)   # Location E
@constraint(model, x[2] + x[5] == 1)          # Location F
@constraint(model, x[1] + x[7] + x[8] + x[10] == 1)  # Location G
@constraint(model, x[3] + x[5] + x[10] == 1)  # Location H
@constraint(model, x[2] + x[4] + x[7] == 1)   # Location I

# Constraint: Exactly 3 routes must be selected
@constraint(model, sum(x) == 3)

# Solve the model
optimize!(model)

# Results: Print the selected routes and the minimum total time
println("Selected routes:")
for i in 1:10
    if value(x[i]) > 0.5
        println("Route $i")
    end
end

println("Minimum total time: ", objective_value(model))





#problem 3
using JuMP, GLPK

# Create the model
model = Model(GLPK.Optimizer)

# Define binary decision variables for each project
@variable(model, x[1:5], Bin)

# Define binary variable z for the Either-Or constraint
@variable(model, z, Bin)

# Objective function: Maximize total profit
@objective(model, Max, 1*x[1] + 1.8*x[2] + 1.6*x[3] + 0.8*x[4] + 1.4*x[5])

# Budget constraint: Total capital cannot exceed 20 million
@constraint(model, 6*x[1] + 12*x[2] + 10*x[3] + 4*x[4] + 8*x[5] <= 20)

# Big M (large constant)
M = 1000

# Either-Or constraints
@constraint(model, x[1] + x[2] + x[3] + x[4] + x[5] >= 3 - M*z)  # First constraint with z = 0
@constraint(model, 2*x[1] + 6*x[2] + 3*x[3] + 5*x[4] + x[5] >= 11 - M*(1 - z))  # Second constraint with z = 1

# Solve the model
optimize!(model)

# Check solver termination status
status = termination_status(model)
println("Solver status: ", status)

if status == MOI.OPTIMAL
    # If solution is optimal, print selected projects and maximum profit
    println("Selected projects:")
    for i in 1:5
        if value(x[i]) > 0.5
            println("Project $i")
        end
    end
    println("Maximum profit: ", objective_value(model))
else
    println("The problem could not be solved to optimality.")
end




#Problem 4 
using JuMP, GLPK

# Create the model
model = Model(GLPK.Optimizer)

# Define the decision variables as binary
@variable(model, x[1:3], Bin)

# Objective function: Maximize Z
@objective(model, Max, -4*x[1] - 5*x[2] - 7*x[3])

# Constraints
@constraint(model, -x[1] + 3*x[2] + 2*x[3] >= 1)
@constraint(model, 2*x[1] + x[2] + 3*x[3] >= 0)

# Solve the root node (LP Relaxation)
optimize!(model)
println("Root Node (LP Relaxation) Solution:")
println("x1 = ", value(x[1]))
println("x2 = ", value(x[2]))
println("x3 = ", value(x[3]))
println("Objective value = ", objective_value(model))

# Branch 1: Fix x2 = 0
x2_constraint = @constraint(model, x[2] == 0)
optimize!(model)

status = termination_status(model)
if status == MOI.OPTIMAL
    println("Branch 1 (x2 = 0) Solution:")
    println("x1 = ", value(x[1]))
    println("x2 = ", value(x[2]))
    println("x3 = ", value(x[3]))
    println("Objective value = ", objective_value(model))
elseif status == MOI.INFEASIBLE
    println("Branch 1 (x2 = 0) is infeasible.")
else
    println("Branch 1 (x2 = 0) could not be solved.")
end

# Delete x2 constraint before continuing to the next branch
JuMP.delete(model, x2_constraint)

# Branch 1a: Fix x3 = 0 after x2 = 0
x2_constraint = @constraint(model, x[2] == 0)  # Recreate x2 constraint
x3_constraint = @constraint(model, x[3] == 0)  # Fix x3 = 0
optimize!(model)

status = termination_status(model)
if status == MOI.OPTIMAL
    println("Branch 1a (x2 = 0, x3 = 0) Solution:")
    println("x1 = ", value(x[1]))
    println("x2 = ", value(x[2]))
    println("x3 = ", value(x[3]))
    println("Objective value = ", objective_value(model))
elseif status == MOI.INFEASIBLE
    println("Branch 1a (x2 = 0, x3 = 0) is infeasible.")
else
    println("Branch 1a (x2 = 0, x3 = 0) could not be solved.")
end

# Clean up before next branch
JuMP.delete(model, x2_constraint)
JuMP.delete(model, x3_constraint)

# Branch 1b: Fix x3 = 1 after x2 = 0
x2_constraint = @constraint(model, x[2] == 0)  # Re-fix x2 = 0
x3_constraint = @constraint(model, x[3] == 1)  # Fix x3 = 1
optimize!(model)

status = termination_status(model)
if status == MOI.OPTIMAL
    println("Branch 1b (x2 = 0, x3 = 1) Solution:")
    println("x1 = ", value(x[1]))
    println("x2 = ", value(x[2]))
    println("x3 = ", value(x[3]))
    println("Objective value = ", objective_value(model))
elseif status == MOI.INFEASIBLE
    println("Branch 1b (x2 = 0, x3 = 1) is infeasible.")
else
    println("Branch 1b (x2 = 0, x3 = 1) could not be solved.")
end

# Clean up before moving to the next branch
JuMP.delete(model, x2_constraint)
JuMP.delete(model, x3_constraint)

# Branch 2: Fix x2 = 1
x2_constraint = @constraint(model, x[2] == 1)  # Fix x2 = 1
optimize!(model)

status = termination_status(model)
if status == MOI.OPTIMAL
    println("Branch 2 (x2 = 1) Solution:")
    println("x1 = ", value(x[1]))
    println("x2 = ", value(x[2]))
    println("x3 = ", value(x[3]))
    println("Objective value = ", objective_value(model))
elseif status == MOI.INFEASIBLE
    println("Branch 2 (x2 = 1) is infeasible.")
else
    println("Branch 2 (x2 = 1) could not be solved.")
end

# Clean up before continuing
JuMP.delete(model, x2_constraint)

# Branch 2a: Fix x2 = 1 and x3 = 0
x2_constraint = @constraint(model, x[2] == 1)  # Fix x2 = 1
x3_constraint = @constraint(model, x[3] == 0)  # Fix x3 = 0
optimize!(model)

status = termination_status(model)
if status == MOI.OPTIMAL
    println("Branch 2a (x2 = 1, x3 = 0) Solution:")
    println("x1 = ", value(x[1]))
    println("x2 = ", value(x[2]))
    println("x3 = ", value(x[3]))
    println("Objective value = ", objective_value(model))
elseif status == MOI.INFEASIBLE
    println("Branch 2a (x2 = 1, x3 = 0) is infeasible.")
else
    println("Branch 2a (x2 = 1, x3 = 0) could not be solved.")
end

# Clean up before moving to Branch 2b
JuMP.delete(model, x2_constraint)
JuMP.delete(model, x3_constraint)

# Branch 2b: Fix x2 = 1 and x3 = 1
x2_constraint = @constraint(model, x[2] == 1)  # Fix x2 = 1
x3_constraint = @constraint(model, x[3] == 1)  # Fix x3 = 1
optimize!(model)

status = termination_status(model)
if status == MOI.OPTIMAL
    println("Branch 2b (x2 = 1, x3 = 1) Solution:")
    println("x1 = ", value(x[1]))
    println("x2 = ", value(x[2]))
    println("x3 = ", value(x[3]))
    println("Objective value = ", objective_value(model))
elseif status == MOI.INFEASIBLE
    println("Branch 2b (x2 = 1, x3 = 1) is infeasible.")
else
    println("Branch 2b (x2 = 1, x3 = 1) could not be solved.")
end

# Clean up at the end
JuMP.delete(model, x2_constraint)
JuMP.delete(model, x3_constraint)



