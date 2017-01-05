package sortables;

/**
 * Created by Nick on 2017-01-03.
 */
public class RemoveEmpties extends RemoveElements<String> {
    private RemoveEmpties() {}

    public static RemoveEmpties newInstance() {
        return new RemoveEmpties();
    }

    @Override
    public boolean isElementToRemove(String s) {
        return "".equals(s);
    }
}
