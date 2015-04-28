class MyCostFunction
{
  inherit Ceres.CostFunction;

  Ceres.ResidualBlock evaluate (array(Ceres.ParameterBlock) pbs)
  {
    Ceres.ResidualBlock rb = Ceres.ResidualBlock (2);

    rb[0] = 1 - exp (2 + pbs[0][0]);
    rb[1] = 2 - exp (4 + pbs[0][1]);

    return rb;
  }
}

int main(int argc, array argv)
{
  MyCostFunction mcf = MyCostFunction();
  Ceres.AutoDiffSolver solver = Ceres.AutoDiffSolver();
  array(array(float)) initial_params = ({ ({ 0.0, 0.0 }) });
  array(array(float)) result = solver->solve (mcf, initial_params);
  werror ("result: %O\n", result);
}
