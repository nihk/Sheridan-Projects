package sortables;

/**
 * Created by Nick on 2017-01-03.
 */
public class RemoveNulls<E> extends RemoveElements<E> {
    private RemoveNulls() {}

    public static RemoveNulls newInstance() {
        return new RemoveNulls();
    }

    @Override
    public boolean isElementToRemove(E e) {
        return e == null;
    }
}
