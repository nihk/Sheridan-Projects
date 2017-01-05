package sortables;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Nick on 2017-01-03.
 */
public class RemoveDuplicates<E> implements Sortable<E> {
    private RemoveDuplicates() {}

    public static RemoveDuplicates newInstance() {
        return new RemoveDuplicates();
    }

    @Override
    public void sort(List<E> list) {
        final Set<E> set = new LinkedHashSet<>();
        set.addAll(list);
        list.clear();
        list.addAll(set);
    }
}
